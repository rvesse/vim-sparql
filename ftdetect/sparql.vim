" SPARQL

" Set filetype to SPARQL when reading a buffer or creating a new file
" with the .rq/.ru extension
" Subscribe to all relevant events
"   BufRead		Start of editing after reading from file
"   BufNewFile		Start of editing a new file
"   BufWritePost	After writing a file	
augroup filetypedetect
  au! BufRead,BufNewFile,BufWritePost *.rq setfiletype sparql
  au! BufRead,BufNewFile,BufWritePost *.ru setfiletype sparql
augroup END

" Set fold method to syntax and fold level appropriately
set foldmethod=syntax
set foldlevel=5
