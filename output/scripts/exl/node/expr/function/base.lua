local modname = ...
local ebase = require(modname, 2, 'base')
local efunctionbase = ebase:module(modname)
local common
local context
local fulltype
local functionti
local ilstream

function efunctionbase:init(pr)
	ebase.init(self, pr)
	self.args = pr.args
	self.body = pr.body
	self.rettype = pr.rettype
	if self.rettype then
		self.resultarg = common.createnode{
			name = 'expr.function.argdef',
			spos = self.rettype.spos,
			epos = self.rettype.epos,
			filename = self.rettype.filename,
			lvalue = true,
			rvalue = false,
			typev = self.rettype,
			target = 'result',
		}
	end
end

function efunctionbase:dobuild(pc)
	self.context = context:create(pc)
	for i, arg in ipairs(self.args) do
		arg:build(self.context)
	end
	if self.resultarg then
		self.resultarg:build(self.context)
	end
	local ti = functionti:create{
		args = self.args,
		rettype = self.rettype,
	}
	self.fulltype = fulltype:create(ti, false, true)
	self.constvalue = self
end

function efunctionbase:rcompile(stream)
	if not self.retname then
		self.retname = stream:genname()
		local substream = ilstream:create()
		for i, arg in ipairs(self.args) do
			if not arg.brvalue and arg.blvalue then
				arg.localdef:compile(substream)
			end
		end
		if self.resultarg then
			self.resultarg.localdef:compile(substream)
		end
		self.body:compile(substream)
		substream:append{
			[0]='ancillary',
			'position', -- name
			self.body.epos.row, -- row
			self.body.epos.col, -- col
			self.body.filename or '-', -- filename
		}
		local rettokenargs = {}
		if self.resultarg then
			rettokenargs[1] = {[0]='local', self.resultarg.symbol.id}
		end
		for i, arg in ipairs(self.args) do
			if arg.blvalue then
				table.append(rettokenargs, {[0]='local', arg.symbol.id})
			end
		end
		substream:append{
			[0]='return',
			rettokenargs, -- values
		}
		substream:compact()
		local inargs = {}
		for i, arg in ipairs(self.args) do
			if arg.brvalue then
				table.append(inargs, arg.symbol.id)
			end
		end
		stream:append{
			[0]='move',
			{[0]='function', inargs, substream.trace}, -- source
			{[0]='ssa', self.retname}, -- target
		}
	end
	return self.retname
end

common = require(modname, 4, 'common')
context = require(modname, 4, 'context')
fulltype = require(modname, 4, 'fulltype')
functionti = require(modname, 1, 'ti')
-- ilstream = require(modname, 4, 'il.stream')
