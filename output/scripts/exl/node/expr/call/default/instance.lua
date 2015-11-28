local modname = ...
local ebase = require('exl.node.expr.base')
local dinstance = ebase:module(modname)
local fulltype

function dinstance:init(pr)
	ebase.init(self, pr)
	self.context = pr.context
	self.args = pr.args
	self.outargs = pr.outargs
	if pr.ti then
		self.fulltype = fulltype:create(pr.ti, false, true)
	else
		self.fulltype = fulltype:create(nil, false, false)
	end
end

function dinstance:rcompile(stream)
	local basename = self.args[1]:rcompile(stream)
	local innames = {}
	for i = 1, #self.args - 1 do
		innames[i] = self.args[i+1]:rcompile(stream)
	end
	local outnames = {}
	local retname
	if self.fulltype.rvalue then
		retname = stream:genname()
		outnames[1] = retname
	end
	for i, oarg in ipairs(self.outargs) do
		table.append(outnames, stream:genname())
	end
	stream:writetoken('a_call', basename, outnames, innames)
	for i, oarg in ipairs(self.outargs) do
		if retname then
			oarg:lcompile(stream, outnames[i+1])
		else
			oarg:lcompile(stream, outnames[i])
		end
	end
	return retname
end

fulltype = require('exl.fulltype')
