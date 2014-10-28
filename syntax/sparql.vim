" Vim syntax file 
" Language: SPARQL 
" Maintainer: Rob Vesse <rvesse@dotnetrdf.org
" Last Change: 23/10/2014
" Remark: 
" Uses the SPARQL 1.1 grammar from http://www.w3.org/TR/sparql11-query/#sparqlGrammar

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Folding Regions
" Must be defined first so later matches can override the colours
" Firstly define our own default folding regions
syntax region sparqlGraphPatternFold start="{" end="}" transparent fold
syntax region sparqlBlankNodeFold start="\[" end="\]" transparent fold
syntax region sparqlFunctionOrCollectionFold start="(" end=")" transparent fold

" Then enable a rainbow parenthesis plugin if available which will override our
" folding regions
" This means that the plugins can be toggled on/off on the fly and our own folding 
" behaviour will be preserved
if exists("g:rainbow_active") && g:rainbow_active
  " Use rainbow braces improved plugin where available
  " https://github.com/oblitum/rainbow

  " Ensure we have configured it for our syntax as otherwise it will break URI highlighting
  call rainbow#clear ()
  call rainbow#load([['(', ')'], ['\[', '\]'], ['{', '}']], '')
  call rainbow#activate ()
elseif exists("g:btm_rainbow_color") && g:btm_rainbow_color
  " Use rainbow braces plugin when available
  " BUG This will break folding unfortunately
  call rainbow_parenthsis#LoadRound ()
  call rainbow_parenthsis#LoadSquare ()
  call rainbow_parenthsis#LoadBraces ()
  call rainbow_parenthsis#Activate ()
endif

" Provide auto-expansion of prefixes using prefix.cc
:nmap <silent> \p <ESC>:let @p = system("CO=$(curl -m 10 -s http://prefix.cc/".expand("<cword>").".file.txt);NL=$(echo \"$CO\"\|wc -l);if [ \"$NL\" -gt 1 ];then echo -n \"NOTFOUND\";else echo \"$CO\"\|cut -f2\|tr -d '\n';fi")<CR>ciw<C-r>p<ESC>

" 19.8 - Note 1 - Keywords are matched in a case-insensitive manner (except a, true and false)
syntax case ignore
syntax keyword sparqlKeyword BASE PREFIX SELECT CONSTRUCT DESCRIBE ASK FROM NAMED DISTINCT REDUCED WHERE ORDER BY ASC DESC LIMIT OFFSET GROUP HAVING OPTIONAL GRAPH UNION VALUES UNDEF MINUS SERVICE BIND AS FILTER LOAD CLEAR DROP CREATE ADD MOVE COPY SILENT INTO TO INSERT DELETE DATA WITH USING DEFAULT NAMED ALL
syntax keyword sparqlFunctionKeywords STR LANG LANGMATCHES DATATYPE BOUND IRI URI BNODE RAND ABS CEIL FLOOR ROUND CONCAT SUBSTR STRLEN REPLACE UCASE LCASE STRSTARTS STRENDS STRBEFORE STRAFTER YEAR MONTH DAY HOURS MINUTES SECONDS TIMEZONE TZ NOW UUID STRUUID COALESCE IF STRLANG STRDT SAMETERM ISIRI ISURI ISBLANK ISLITERAL ISNUMERIC REGEX EXISTS NOT IN COUNT SUM SAMPLE MIN MAX SEPARATOR MD5 SHA1 SHA256 SHA384 SHA512 ENCODE_FOR_URI GROUP_CONCAT

" Have to use a regex rule for the CONTAINS keyword because contains is also an argument to syntax rules
" so trying to use it literally in a keyword rule results in cryptic errors
syntax match sparqlContainsKeyword /\<[cC][oO][nN][tT][aA][iI][nN][sS]\>/ contains=NONE

" case sensitive keywords 
syntax case match
syntax keyword sparqlRdfType a
syntax keyword sparqlBoolean true false 
syntax keyword Todo TODO FIXME BUG 

" 19.4 - Comments 
syntax match sparqlComment /\#.*$/ contains=Todo,sparqlCodepointEscape,@Spell

" Operators
syntax match sparqlOperators "\v\*|/|\+|-|\<\=?|\>\=?|!\=?|\=|\&\&|\|\|"

" 19.2 and 19.7 - Escape sequences  
syntax match sparqlCodepointEscape /\(\\U\x\{8\}\|\\u\x\{4\}\)/ contained contains=NONE
syntax match sparqlStringEscape +\\[tnrbf\"']\++ contained contains=NONE

" 19.8 - Strings - Productions 156,157,158,159
syntax match sparqlStringSingle +'\([^\u0027\u005C\u000A\u000D]\|\\[tnrbf\\"']\+\|\\U\x\{8\}\|\\u\x\{4\}\)*'+ contains=sparqlStringEscape,sparqlCodepointEscape,@Spell oneline
syntax match sparqlStringDouble +"\([^\u0022\u005C\u000A\u000D]\|\\[tnrbf\\"']\+\|\\U\x\{8\}\|\\u\x\{4\}\)*"+ contains=sparqlStringEscape,sparqlCodepointEscape,@Spell oneline
syntax region sparqlStringLongSingle start=+'''+ end=+'''+ contains=sparqlStringEscape,sparqlCodepointEscape,@Spell 
syntax region sparqlStringLongDouble start=+"""+ end=+"""+ contains=sparqlStringEscape,sparqlCodepointEscape,@Spell 
syntax cluster sparqlString contains=sparqlStringSingle,sparqlStringDouble,sparqlStringLongSingle

" 19.8 - Prefixed Names - Production 137
" TODO Currently matches the SPARQL 1.0 production and not the SPARQL 1.1 production
" TODO Currently matches only the prefix portion, should also have rule to match local name portions
" TODO Does not match named blank nodes
syntax match sparqlQnamePrefix /\(\w\|\\U\x\{8\}\|\\u\x\{4\}\)\+:/he=e-1 contains=sparqlCodepointEscape

" 19.8 - IRIs - Production 139
syntax match sparqlIllegalIriNewline "\v\<([^<>'{}]|\s|\n|\r)*\>" contains=sparqlCodepointEscape
syntax match sparqlIllegalIriWhitespace /<[^<>'{}]*>/ contains=sparqlCodepointEscape
syntax match sparqlIri /<[^<>'{}|^`\u00-\u20]*>/ contains=sparqlCodepointEscape oneline

" TODO Rule for anonymous blank nodes i.e. []
" TODO Rule for named blank nodes i.e. _:name

" 19.8 - Variables - Productions 143, 144 and 166
" (JPU: High code points crash my vim, too many character classes SEGV my vim
"  I'll just keep it simple for now: recognize word-class characters plus
"  escapes: )
syntax match sparqlVar /[?$]\{1\}\(\w\|\\U\x\{8\}\|\\u\x\{4\}\)\+/ contains=sparqlCodepointEscape

" 19.8 - Numerics - Productions 146, 147 and 148
syntax case ignore
syntax match sparqlInteger "\v\d+"
syntax match sparqlDecimal "\v\d+\.\d+"
syntax match sparqlDouble "\v\d+\.?\d*[eE][-+]?\d+"
syntax match sparqlExpOnlyDouble "\v\.[eE][-+]?\d+"
syntax match sparqlNoFloatingPointDouble "\v\d+[eE][-+]?\d+"

" Apply highlighting
highlight link sparqlKeyword Keyword 
highlight link sparqlFunctionKeywords Function
highlight link sparqlContainsKeyword Function
highlight link sparqlOperators Operator
highlight link sparqlVar Identifier 
highlight link sparqlStringSingle String 
highlight link sparqlStringLongSingle String 
highlight link sparqlStringDouble String 
highlight link sparqlStringLongDouble String 
highlight link sparqlComment Comment
highlight link sparqlRdfType Constant 
highlight link sparqlIri Identifier
highlight link sparqlIllegalIriWhitespace Error
highlight link sparqlIllegalIriNewline Error
highlight link sparqlBoolean Boolean
highlight link sparqlInteger Number
highlight link sparqlDecimal Number
highlight link sparqlDouble Number
highlight link sparqlExpOnlyDouble Number
highlight link sparqlNoFloatingPointDouble Number
highlight link sparqlQnamePrefix Macro
highlight link sparqlCodepointEscape SpecialChar 
highlight link sparqlStringEscape SpecialChar

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sparql_syn_inits")
  if version < 508
    let did_sparql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

"  HiLink mysqlKeyword		 Statement

  delcommand HiLink
endif

let b:current_syntax = "sparql"

