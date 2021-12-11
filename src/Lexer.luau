-- Lexer.lua
-- The main lua lexer

local lexer = {}

--// Vars
local patterns = require(script.Patterns)
local wordScanner = require(script.ScanWords)

--// Funcs
local function GetMatch(inputStr)
	for _, p in pairs(patterns) do
		local f1, f2 = string.find(inputStr, p.pattern)
		
		if f1 then
			local matches = string.match(inputStr, p.pattern)
			local raw = string.sub(inputStr, f1, f2)
			return {matches}, raw, p.name
		end
	end
	
	return nil
end

--// Module funcs
function lexer:next()
	local remainingStr = string.sub(self.input, self.position, self.inputLen)
	local matches, raw, token = GetMatch(remainingStr)
	
	assert(matches, "Couldn't find any matches at position "..self.position)
	
	table.insert(self.result, {
		raw = raw,
		matches = matches,
		type = token
	})
	
	self.position += #raw
	
	if not (self.position > self.inputLen) then
		self:next()
	end
end

function lexer:Parse(input)
	self.input = input
	self.position = 1
	self.inputLen = #input
	self.result = {}
	
	self:next()
	
	self.result = wordScanner.Scan(self.result)
	
	return self.result
end

return lexer