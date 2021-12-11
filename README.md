# Luau Lexer

## Module structure
```
   Lexer
    └─ Patterns
    └─ ScanWords
        └─ Bools
        └─ Globals
        └─ Keywords
```

### Examples of use
#### Parsing a lua string
Some arbitrary code:
```luau
local something = "a string"
print("this is " .. something)
```

Parsing it:
```lua
local source = [[local something = "a string"
print("this is " .. something)]]
local lexer = require(lexer)
local parsed = lexer:Parse(source)

print(parsed)
```

Outputs:
```lua
{
    ["matches"] =  ▶ {...},
    ["raw"] = "local",
    ["type"] = "keyword"
},
{
    ["matches"] =  ▶ {...},
    ["raw"] = " ",
    ["type"] = "whitespace"
},
{
    ["matches"] =  ▶ {...},
    ["raw"] = "something",
    ["type"] = "word"
},
...
-- Shortened for simplicity
```

### What does the output mean?
#### matches
The exact string that was matched with string.match.

#### raw
In most cases, the same as matches[1]. This just excludes any string captures.

#### type
The type of "token" each part of the string has.