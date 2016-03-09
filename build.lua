do
	local gt = setmetatable({}, {
		__index = _G,
		__newindex = function(t,i,v)
			error('attempt to set global ' .. tostring(i))
		end,
	})
	_G = gt
	setfenv(1, gt)
end

local currenttarget = ...
currenttarget = currenttarget or 'all'

local ffi = require('ffi')

function table.append(arr, item)
	local pos = #arr + 1
	arr[pos] = item
	return pos
end

function table.pop(arr)
	local pos = #arr
	local item = arr[pos]
	arr[pos] = nil
	return item
end

local path_sep = ffi.abi('win') and '\\' or '/'

local function path(str)
	return string.gsub(str, '/', path_sep)
end

local platform = _G.platform or ({
	['Windows-x86'] = 'win32',
	['Windows-x64'] = 'win64',
})[ffi.os .. '-' .. ffi.arch] or error('unknown platform')

local builddir = 'build/' .. platform
local luacpath = builddir .. '/luac.exe'

local function execute(str)
	-- print(str)
	-- if os.execute(str) ~= 0 then
		-- error('build failed')
	-- end
end

local function execute_noerr(str)
	-- print(str)
	-- os.execute(str)
end

local function build_clean(entry)
	for i, dep in ipairs(entry.directories) do
		execute_noerr(string.format(
			'rd /s /q "%s"',
			path(dep)))
	end
	for i, dep in ipairs(entry.files) do
		execute_noerr(string.format(
			'del /q "%s"',
			path(dep)))
	end
end

local function build_dirlist(entry)
	for i, dep in ipairs(entry.directories) do
		execute_noerr(string.format(
			'md "%s"',
			path(dep)))
	end
end

local function build_touch(entry)
	local tpath = path(entry.target)
	execute(string.format(
		'copy /b "%s"+,, "%s"',
		tpath, tpath))
end

local build_lua_format = path(luacpath) .. ' "%s" "%s"'
local function build_lua(entry)
	execute(string.format(
		build_lua_format,
		path(entry.target), path(entry.dependencies[1])))
end

local function build_methodlist(entry)
	local depstr = {}
	for i = 2, #entry.dependencies do
		depstr[i-1] = '"' .. path(entry.dependencies[i]) .. '"'
	end
	execute(string.format(
		'lua \z
			-g extraclasses "" \z
			-g extraheaders "common.hpp cinttypes" \z
			-g structname "methodlist" \z
			-g packageprefix "host." \z
			-g compactffi "true" \z
			-g defaultlparent "base.ffipure" \z
			-g fileprefix "%s" \z
			bind.lua %s',
		path(entry.target), table.concat(depstr, ' ')))
end

local function build_luainit(entry)
	local depstr = {}
	for i = 2, #entry.dependencies do
		depstr[i-1] = '"' .. path(entry.dependencies[i]) .. '"'
	end
	execute(string.format(
		'lua \z
			-g structname "luainit" \z
			-g fileprefix "%s" \z
			embed.lua %s',
		path(entry.target), table.concat(depstr, ' ')))
end

local build_cpp_format =
	'g++ \z
		-o "%s" \z
		"%s" \z
		-c \z
		-O2 \z
		-Wall -Werror \z
		-I. \z
		"-I' .. path(builddir) .. '" \z
		-std=c++11 \z
		-pipe'
local function build_cpp(entry)
	execute(string.format(
		build_cpp_format,
		path(entry.target), path(entry.dependencies[1])))
end

local function build_exe(entry)
	local depstr = {}
	for i = 1, #entry.dependencies do
		depstr[i] = '"' .. path(entry.dependencies[i]) .. '"'
	end
	local libstr = {}
	for i = 1, #entry.libraries do
		libstr[i] = '-l' .. entry.libraries[i]
	end
	execute(string.format(
		'g++ -o "%s" %s \z
			-pipe \z
			-L. \z
			%s',
		path(entry.target), table.concat(depstr, ' '), table.concat(libstr, ' ')))
end

ffi.cdef[[
bool __stdcall CloseHandle(
	void const* hObject
);
void const* __stdcall CreateFileA(
	char const* lpFileName,
	uint32_t dwDesiredAccess,
	uint32_t dwShareMode,
	void const* lpSecurityAttributes,
	uint32_t dwCreationDisposition,
	uint32_t dwFlagsAndAttributes,
	void const* hTemplateFile
);
bool __stdcall GetFileTime(
	void const* hFile,
	uint64_t* lpCreationTime,
	uint64_t* lpLastAccessTime,
	uint64_t* lpLastWriteTime
);
]]

local function entry_filltime(entry)
	local handle = ffi.C.CreateFileA(
		path(entry.target),
		0x80000000, -- GENERIC_READ
		7, -- FILE_SHARE_READ || FILE_SHARE_WRITE || FILE_SHARE_DELETE
		nil,
		3, -- OPEN_EXISTING
		0x80, -- FILE_ATTRIBUTE_NORMAL
		nil)
	if handle ~= nil then
		local lwt = ffi.new('uint64_t[1]')
		if ffi.C.GetFileTime(handle, nil, nil, lwt) then
			entry.time = lwt[0]
		end
		ffi.C.CloseHandle(handle)
	end
end

local targets = {}

table.append(targets, {
	build = build_dirlist,
	target = builddir,
	dependencies = {},
	directories = {
		builddir,
		builddir .. '/utils',
		builddir .. '/rsbin',
		builddir .. '/graphics',
		builddir .. '/luainit',
		builddir .. '/client-console',
		builddir .. '/client-main',
	},
	time = 0xffffffffffffffffULL,
	forcebuild = true,
})

table.append(targets, {
	build = build_touch,
	target = 'offline utility/luac.cpp',
	dependencies = {},
	autodep = true,
})
table.append(targets, {
	build = build_cpp,
	target = builddir .. '/luac.o',
	dependencies = {
		'offline utility/luac.cpp',
		builddir,
	},
})
table.append(targets, {
	build = build_exe,
	target = luacpath,
	dependencies = {
		builddir .. '/luac.o',
	},
	libraries = {
		'luajit-' .. platform,
	},
})

table.append(targets, {
	build = build_touch,
	target = 'client-console/main.cpp',
	dependencies = {},
	autodep = true,
})
table.append(targets, {
	build = build_cpp,
	target = builddir .. '/client-console/main.o',
	dependencies = {
		'client-console/main.cpp',
		builddir,
	},
})

for i, unit in ipairs{
	'client-console/window',
	'utils/cbase',
	'utils/configset',
	'utils/console',
	'utils/cyclicbuffer',
	'utils/databuffer',
	'utils/encoding',
	'utils/flaglock',
	'utils/mpscqueue',
	'utils/path',
	'utils/profile',
	'utils/ref',
	'utils/refobject',
	'utils/strexception',
	'utils/string',
	'rsbin/common',
	'rsbin/fileio',
	'rsbin/fsthread',
	'rsbin/pngreader',
	'rsbin/pngwriter',
} do
	table.append(targets, {
		build = build_touch,
		target = unit .. '.cpp',
		dependencies = {},
		autodep = true,
	})
	table.append(targets, {
		build = build_touch,
		target = unit .. '.hpp',
		dependencies = {},
		autodep = true,
	})
	table.append(targets, {
		build = build_cpp,
		target = builddir .. '/' .. unit .. '.o',
		dependencies = {
			unit .. '.cpp',
			builddir,
		},
	})
end

table.append(targets, {
	build = build_methodlist,
	target = builddir .. '/client-console/methodlist',
	dependencies = {
		builddir,
		'utils/cbase.hpp',
		'utils/configset.hpp',
		'utils/databuffer.hpp',
		'utils/encoding.hpp',
		'utils/refobject.hpp',
		'rsbin/common.hpp',
		'rsbin/fsthread.hpp',
		'rsbin/fileio.hpp',
		'rsbin/pngreader.hpp',
		'rsbin/pngwriter.hpp',
		'client-console/window.hpp',
	},
})
table.append(targets, {
	target = builddir .. '/client-console/methodlist.cpp',
	dependencies = {
		builddir .. '/client-console/methodlist',
		builddir,
	},
})
table.append(targets, {
	target = builddir .. '/client-console/methodlist.hpp',
	dependencies = {
		builddir .. '/client-console/methodlist',
		builddir,
	},
})
table.append(targets, {
	target = 'client-console/methodlist.cpp',
	dependencies = {
		builddir .. '/client-console/methodlist.cpp',
	},
})
table.append(targets, {
	target = 'client-console/methodlist.hpp',
	dependencies = {
		builddir .. '/client-console/methodlist.hpp',
	},
})
table.append(targets, {
	build = build_cpp,
	target = builddir .. '/client-console/methodlist.o',
	dependencies = {
		builddir .. '/client-console/methodlist.cpp',
		builddir,
	},
})
table.append(targets, {
	target = builddir .. '/client-console/methodlist.lua',
	dependencies = {
		builddir .. '/client-console/methodlist',
		builddir,
	},
})

for i, unit in ipairs{
	'luainit/main',
	'luainit/baselib',
	'luainit/object',
	'luainit/ffipure',
	'luainit/hostlib',
} do
	table.append(targets, {
		target = unit .. '.lua',
		dependencies = {},
	})
	table.append(targets, {
		build = build_lua,
		target = builddir .. '/' .. unit .. '.lb',
		dependencies = {
			unit .. '.lua',
			luacpath,
			builddir,
		},
	})
end

table.append(targets, {
	build = build_lua,
	target = builddir .. '/client-console/methodlist.lb',
	dependencies = {
		builddir .. '/client-console/methodlist.lua',
		luacpath,
		builddir,
	},
})

table.append(targets, {
	build = build_luainit,
	target = builddir .. '/client-console/luainit',
	dependencies = {
		builddir,
		builddir .. '/luainit/main.lb',
		builddir .. '/luainit/baselib.lb',
		builddir .. '/luainit/object.lb',
		builddir .. '/luainit/ffipure.lb',
		builddir .. '/client-console/methodlist.lb',
		builddir .. '/luainit/hostlib.lb',
	},
})
table.append(targets, {
	target = builddir .. '/client-console/luainit.cpp',
	dependencies = {
		builddir .. '/client-console/luainit',
		builddir,
	},
})
table.append(targets, {
	target = builddir .. '/client-console/luainit.hpp',
	dependencies = {
		builddir .. '/client-console/luainit',
		builddir,
	},
})
table.append(targets, {
	target = 'client-console/luainit.cpp',
	dependencies = {
		builddir .. '/client-console/luainit.cpp',
	},
})
table.append(targets, {
	target = 'client-console/luainit.hpp',
	dependencies = {
		builddir .. '/client-console/luainit.hpp',
	},
})
table.append(targets, {
	build = build_cpp,
	target = builddir .. '/client-console/luainit.o',
	dependencies = {
		builddir .. '/client-console/luainit.cpp',
		builddir,
	},
})

table.append(targets, {
	build = build_exe,
	target = 'output/client-console-' .. platform .. '.exe',
	dependencies = {
		builddir .. '/utils/cbase.o',
		builddir .. '/utils/configset.o',
		builddir .. '/utils/console.o',
		builddir .. '/utils/cyclicbuffer.o',
		builddir .. '/utils/databuffer.o',
		builddir .. '/utils/encoding.o',
		builddir .. '/utils/flaglock.o',
		builddir .. '/utils/mpscqueue.o',
		builddir .. '/utils/path.o',
		builddir .. '/utils/profile.o',
		builddir .. '/utils/ref.o',
		builddir .. '/utils/refobject.o',
		builddir .. '/utils/strexception.o',
		builddir .. '/utils/string.o',
		builddir .. '/rsbin/common.o',
		builddir .. '/rsbin/fileio.o',
		builddir .. '/rsbin/fsthread.o',
		builddir .. '/rsbin/pngreader.o',
		builddir .. '/rsbin/pngwriter.o',
		builddir .. '/client-console/luainit.o',
		builddir .. '/client-console/main.o',
		builddir .. '/client-console/methodlist.o',
		builddir .. '/client-console/window.o',
	},
	libraries = {
		'luajit-' .. platform,
		'png-' .. platform,
		'z',
	},
})

table.append(targets, {
	target = 'all',
	dependencies = {
		'output/client-console-' .. platform .. '.exe',
	},
})

table.append(targets, {
	build = build_clean,
	target = 'clean',
	dependencies = {},
	forcebuild = true,
	directories = {
		builddir,
	},
	files = {
		'output/client-console-' .. platform .. '.exe',
	},
})

for i, entry in ipairs(targets) do
	targets[entry.target] = entry
end

local function fill_dependencies(entry)
	local f, err = io.open(path(entry.target), 'r')
	if not f then
		return
	end
	for line in f:lines() do
		local fn = string.match(line, '#%s*include%s*<(.*)>')
		if fn and targets[fn] then
			table.append(entry.dependencies, fn)
		end
	end
end

for i, entry in ipairs(targets) do
	if entry.autodep then
		fill_dependencies(entry)
	end
end

local function add_target(list, set, tname)
	if set[tname] then
		return list
	end
	local entry = targets[tname]
	if not entry then
		error('cannot find target ' .. tname)
	end
	table.append(list, entry)
	set[tname] = true
	for i, dep in ipairs(entry.dependencies) do
		add_target(list, set, dep)
	end
	return list
end

do
	local result = {}
	local ready = {}
	local current = add_target({}, {}, currenttarget)
	while #current ~= 0 do
		local next = {}
		for i, entry in ipairs(current) do
			for j, dep in ipairs(entry.dependencies) do
				if not ready[dep] then
					table.append(next, entry)
					goto notready
				end
			end
			ready[entry.target] = true
			table.append(result, entry)
		::notready::
		end
		if #next == #current then
			for i, entry in ipairs(current) do
				print(string.format('target %s:', entry.target))
				for j, dep in ipairs(entry.dependencies) do
					print(string.format('\t%s', dep))
				end
			end
			error('cannot resolve dependency graph')
		end
		current = next
	end
	targets = result
end

for i, entry in ipairs(targets) do
	targets[entry.target] = entry
end

for i, entry in ipairs(targets) do
	entry_filltime(entry)
	for j, dep in ipairs(entry.dependencies) do
		local depentry = targets[dep]
		if
			depentry.update or
			(entry.time and depentry.time and depentry.time > entry.time)
		then
			print(entry.target, entry.time, depentry.target, depentry.time)
			entry.update = true
		end
	end
	if entry.build and (entry.update or entry.forcebuild) then
		print(entry.target)
		entry:build()
	end
end
