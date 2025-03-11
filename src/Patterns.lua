-- Lexer.lua/Patterns.lua
-- String patterns the lexer uses to search and identify types
-- Always start patterns with ^ to indicate the beginning, and never use $ at end

local patterns = {
	{
		pattern = "^%[%[.-%]%]",
		name = "string"
	},
	{
		pattern = "^%-%-[^\n]*",
		name = "comment"
	},
	{
		pattern = "^%-%-%[%[.-%]%]",
		name = "comment"
	},
	{
		pattern = "^([\"']).-[^\\]%1",
		name = "string"
	},
	{
		pattern = "^([\"'])%1",
		name = "string"
	},
	{
		pattern = "^0x%w+",
		name = "hexadecimal"
	},
	{
		pattern = "^%d+%.%d+",
		name = "float"
	},
	{
		pattern = "^%d+",
		name = "int"
	},
	{
		pattern = "^(==|~=|<=|>=|%.%.%.?|[%-%+/%*=<>])",
		name = "operator"
	},
	{
		pattern = "^([{}%(%)%[%]%;%,:%.])",
		name = "punctuation"
	},
	{
		pattern = "^%w+",
		name = "word"
	},
	{
		pattern = "^%s+",
		name = "whitespace"
	},
	{
		pattern = "^.",
		name = "unknown"
	}
}

return patterns
