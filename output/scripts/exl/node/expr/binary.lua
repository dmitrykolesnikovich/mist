local modname = ...
local ebase = require('exl.node.expr.base')
local ebinary = ebase:module(modname)
local common
-- local prototype

local symbols = {
	concat = '..',

	mul = '*',
	div = '/',

	add = '+',
	sub = '-',

	assign = '=',
	adda = '+=',
	suba = '-=',
}

local defaultfunc = {
	assign = require('exl.node.expr.binary.defassign.func'),
}

function ebinary:init(pr)
	ebase.init(self, pr)
	self.operator = pr.operator
	self.left = pr.left
	self.right = pr.right
end

function ebinary:build(pc)
	if self.left then
		self.left:build(pc)
	end
	if self.right then
		self.right:build(pc)
	end
	if not self.left or not self.right then
		return
	end
	local leftft = self.left:getfulltype()
	local rightft = self.right:getfulltype()
	local opset = pc:getopset()
	local operatorfunc = opset:resolve(
		self.operator,
		{leftft, rightft})
	if not operatorfunc then
		operatorfunc = defaultfunc[self.operator]
	end
	if operatorfunc then
		self.operatorinstance =
			operatorfunc:createinstance{
				context = pc,
				self.left,
				self.right}
	end
	if self.operatorinstance then
		self.constvalue = self.operatorinstance:getconstvalue()
		self.fulltype = self.operatorinstance:getfulltype()
	else
		pc.env:log(
			'error',
			string.format('cannot resolve operator%s(%s, %s)',
				symbols[self.operator],
				leftft, rightft),
			self.spos, self.epos)
		return
	end
end

function ebinary:lcompile(stream, source)
	if self.operatorinstance then
		return self.operatorinstance:lcompile(stream, source)
	end
end

function ebinary:rcompile(stream)
	if self.constvalue and self.constvalue.bsimplevalue then
		return self.constvalue:rcompile(stream)
	elseif self.operatorinstance then
		return self.operatorinstance:rcompile(stream)
	end
end

function ebinary:defstring(lp)
	-- if self.constvalue then
		-- return common.defstring(self.constvalue, lp .. self.lpindent)
	-- else
		return string.format('(%s %s %s)',
			common.defstring(self.left, lp .. self.lpindent),
			symbols[self.operator],
			common.defstring(self.right, lp .. self.lpindent))
	-- end
end

common = require('exl.common')
-- prototype = require('exl.prototype')
