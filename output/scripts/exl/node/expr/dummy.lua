local modname = ...
local ebase = require('exl.node.expr.base')
local edummy = ebase:module(modname)
local common

function edummy:init(pr)
	ebase.init(self, pr)
	self.fulltype = pr.fulltype
end

function edummy:lcompile(stream, source)
	self.retname = source
end

common = require('exl.common')
