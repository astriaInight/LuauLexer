# Luau Lexer

## Module structure
- The location of each module is also listed at the top of the file
- You can make the latest version of this module by downloading/cloning the repo and organizing the files as stated below...
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
}
-- Shortened for simplicity (there are gonna be more than 3 tokens, ofc)
```

### What does the output mean?
#### matches
List of exact strings (or string captures) that were matched with `string.match`.

#### raw
In most cases, the same as `matches[1]`. This just excludes any string captures.

#### type
The type of "token" each part of the string has.