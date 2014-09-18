" Vim syntax file 
" Language: SPARQL 
" Maintainer: Rob Vesse <rvesse@dotnetrdf.org
" Last Change: 17/9/2014
" Remark: 
" Uses the SPARQL 1.1 grammar from http://www.w3.org/TR/sparql11-query/#sparqlGrammar

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" 19.8 - Note 1 - Keywords are matched in a case-insensitive manner (except a, true and false)
syntax case ignore
syntax keyword rqKeyword BASE PREFIX SELECT CONSTRUCT DESCRIBE ASK FROM NAMED DISTINCT REDUCED WHERE ORDER BY ASC DESC LIMIT OFFSET GROUP HAVING OPTIONAL GRAPH UNION VALUES UNDEF MINUS SERVICE BIND AS FILTER LOAD CLEAR DROP CREATE ADD MOVE COPY SILENT INTO TO INSERT DELETE DATA WITH USING DEFAULT NAMED ALL
syntax keyword rqFunctionKeywords STR LANG LANGMATCHES DATATYPE BOUND IRI URI BNODE RAND ABS CEIL FLOOR ROUND CONCAT SUBSTR STRLEN REPLACE UCASE LCASE STRSTARTS STRENDS STRBEFORE STRAFTER YEAR MONTH DAY HOURS MINUTES SECONDS TIMEZONE TZ NOW UUID STRUUID COALESCE IF STRLANG STRDT SAMETERM ISIRI ISURI ISBLANK ISLITERAL ISNUMERIC REGEX EXISTS NOT IN COUNT SUM SAMPLE MIN MAX SEPARATOR MD5 SHA1 SHA256 SHA384 SHA512 ENCODE_FOR_URI GROUP_CONCAT
syntax match rqContainsKeyword /\<[cC][oO][nN][tT][aA][iI][nN][sS]\>/ contains=NONE
syntax case match

" case sensitive keywords 
syntax keyword rqRdfType a
syntax keyword rqBoolean true false 
syntax keyword Todo TODO FIXME BUG 

" 19.4 - Comments 
syntax match rqComment /\#.*$/ contains=Todo,rqCodepointEscape,@Spell

" Operators
syntax match rqOperators "\v\*|/|\+|-|\<\=?|\>\=?|!\=?|\=|\&\&|\|\|"

" 19.2 and 19.7 - Escape sequences  
syntax match rqCodepointEscape /\(\\U\x\{8\}\|\\u\x\{4\}\)/ contained contains=NONE
syntax match rqStringEscape +\\[tnrbf\"']\++ contained contains=NONE

" 19.8 - Strings - Productions 156,157,158,159
syntax match rqStringSingle +'\([^\u0027\u005C\u000A\u000D]\|\\[tnrbf\\"']\+\|\\U\x\{8\}\|\\u\x\{4\}\)*'+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax match rqStringDouble +"\([^\u0022\u005C\u000A\u000D]\|\\[tnrbf\\"']\+\|\\U\x\{8\}\|\\u\x\{4\}\)*"+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax region rqStringLongSingle start=+'''+ end=+'''+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax region rqStringLongDouble start=+"""+ end=+"""+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax cluster rqString contains=rqStringSingle,rqStringDouble,rqStringLongSingle

" 19.8 - Prefixed Names - Production 137
" TODO Currently matches the SPARQL 1.0 production and not the SPARQL 1.1 production
syntax match rqQnamePrefix /\(\w\|\\U\x\{8\}\|\\u\x\{4\}\)\+:/he=e-1 contains=rqCodepointEscape 

" 19.8 - IRIs - Production 139
" TODO Write a proper IRI rule that actually works
syntax match rqQIRIREF /<[^<>'{}|^`\u00-\u20]*>/ contains=rqCodepointEscape 

" 19.8 - Variables - Productions 143, 144 and 166
" (JPU: High code points crash my vim, too many character classes SEGV my vim
"  I'll just keep it simple for now: recognize word-class characters plus
"  escapes: )
syntax match rqVar /[?$]\{1\}\(\w\|\\U\x\{8\}\|\\u\x\{4\}\)\+/ contains=rqCodepointEscape 

" Apply highlighting
highlight link rqKeyword Keyword 
highlight link rqFunctionKeywords Function
highlight link rqContainsKeyword Function
highlight link rqOperators Operator
highlight link rqVar Identifier 
highlight link rqStringSingle String 
highlight link rqStringLongSingle String 
highlight link rqStringDouble String 
highlight link rqStringLongDouble String 
highlight link rqComment Comment
highlight link rqRdfType Constant 
highlight link rqQIRIREF Identifier
highlight link rqBoolean Boolean
highlight link rqQnamePrefix Macro
highlight link rqCodepointEscape SpecialChar 
highlight link rqStringEscape SpecialChar 


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

