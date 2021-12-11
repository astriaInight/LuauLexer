-- Lexer.lua/ScanWords.lua
-- Scans words found by the lexer and checks if they are keywords/globals
-- Returns adjusted table

local module = {}

--// Vars
local keywords = require(script.Keywords)
local globals = require(script.Globals)
local bools = require(script.Bools)

--// Funcs

--// Module funcs
function module.Scan(lexed)
	for _, comp in pairs(lexed) do
		if comp.type == "word" then
			if keywords[comp.raw] then
				comp.type = "keyword"
			elseif globals[comp.raw] then
				comp.type = "global"
			elseif bools[comp.raw] then
				comp.type = "bool"
			end
		end
	end
	
	return lexed
end

return module