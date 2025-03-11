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
	
	-- return on eof
	if self.position > self.inputLen then
		return
	end
	
	local matches, raw, token = GetMatch(remainingStr)
	
	if not matches then
		-- handle error + advance instead of using assertion here
		table.insert(self.result, {
			raw = string.sub(remainingStr, 1, 1),
			matches = {string.sub(remainingStr, 1, 1)},
			type = "unknown"
		})
		self.position += 1
	else
		table.insert(self.result, {
			raw = raw,
			matches = matches,
			type = token
		})
		self.position += #raw
	end
end

function lexer:Parse(input)
	self.input = input
	self.position = 1
	self.inputLen = #input
	self.result = {}
	
	-- avoid stack overflow calls with a loop
	while self.position <= self.inputLen do
		self:next()
	end
	
	self.result = wordScanner.Scan(self.result)
	
	return self.result
end

return lexer
