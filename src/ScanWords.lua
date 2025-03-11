-- ScanWords.lua
-- Scans words found by the lexer and checks if they are keywords/globals
-- Returns adjusted table

local module = {}

--// Vars
local keywords = require(script.Keywords)
local globals = require(script.Globals)

--// Funcs
local function isIdentifier(word)
	return string.match(word, "^[%a_][%w_]*$") ~= nil
end

--// Module funcs
function module.Scan(lexed)
	for _, comp in pairs(lexed) do
		if comp.type == "word" and isIdentifier(comp.raw) then
			if keywords[comp.raw] then
				comp.type = "keyword"
			elseif comp.raw == "true" or comp.raw == "false" then
				comp.type = "bool"
			elseif globals[comp.raw] then
				comp.type = "global"
			end
		end
	end
	
	return lexed
end

return module
