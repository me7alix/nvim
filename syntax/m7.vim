if exists("b:current_syntax")
  finish
endif

" --- MACROS ---
syn match m7Macro /\v^\s*#[A-Za-z_][A-Za-z0-9_]*/

" --- COMMENTS ---
syn match m7Comment "//.*$"
syn region m7Comment start="/\*" end="\*/" keepend

" --- STRINGS ---
syn region m7String start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region m7String start=+'+ skip=+\\\\\\|\\'+ end=+'+

" --- KEYWORDS ---
syn keyword m7Keyword import if else while for return break continue extern struct null fn

" --- BOOLEANS ---
syn keyword m7Boolean true false

" --- TYPES ---
syn keyword m7Type int float f32 bool u0 iptr uint i64 u64 i32 u32 i16 u16 i8 u8 uptr

" --- NUMBERS ---
syn match m7Number /\v\<\d+(\.\d+)?([eE][+-]?\d+)?\>/

" --- FUNCTION NAMES (must come before variables) ---
syn match m7Func /\v\w+\ze\s*\(/

" --- ARRAY BRACKETS ---
syn match m7Bracket /\v[\[\]]/

" --- OPERATORS ---
syn match m7Operator /[-+*\/=<>!&|]+/

" --- LINK HIGHLIGHT GROUPS ---
hi def link m7Macro PreProc
hi def link m7Comment Comment
hi def link m7String String
hi def link m7Keyword Keyword
hi def link m7Boolean Boolean
hi def link m7Type Type
hi def link m7Number Number
hi def link m7Func Function
hi def link m7Operator Operator
hi def link m7Bracket Special

let b:current_syntax = "m7"
