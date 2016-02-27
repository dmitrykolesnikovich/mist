local modname = ...
local eliteral = require(modname, 1, 'literal')
local estring = eliteral:module(modname, {
	serial = 's',
	fullname = 'string',
})

function estring:init(pr)
	eliteral.init(self, pr)
	self.value = pr.value
end

function estring:rcompile(stream)
	local name = stream:genname()
	stream:writetoken{
		op = 'move',
		args = {
			{'string', self.value}, -- source
			{'ssa', name}, -- target
		},
	}
	return name
end

function estring:defstring(lp)
	return string.format('%q', self.value)
end
