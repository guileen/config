set foldenable
" set foldmethod=indent
" set foldnestmax=2
" set foldminlines=10
" set fillchars=fold:\ ,vert:\|

" " if you want enable syntax fold, use au FileType .. set foldmethod=syntax
" set foldmethod=syntax
" set foldlevelstart=1

" let javaScript_fold=1         " JavaScript
" let perl_fold=1               " Perl
" let php_folding=1             " PHP
" let r_syntax_folding=1        " R
" let ruby_fold=1               " Ruby
" let sh_fold_enabled=1         " sh
" let vimsyn_folding='af'       " Vim script
" let xml_syntax_folding=1      " XML
let g:vim_markdown_folding_disabled=1
let g:syntastic_javascript_checkers = ['eslint']

autocmd BufRead *.as set filetype=actionscript
autocmd BufRead *.mxml set filetype=mxml
autocmd BufRead *.hx set filetype=haxe
autocmd BufRead *.ccss set filetype=clevercss
" autocmd BufRead *.js set shiftwidth=2
autocmd BufRead *.jade,*.haml,*.html set shiftwidth=2
autocmd BufRead *.md,*.markdown noremap <F8> :Mm<Enter>
autocmd BufRead *.coffee noremap <F8> :!coffee -p %<Enter>
autocmd BufRead *.htm,*.html noremap <F8> :!google-chrome %<Enter>
autocmd FileType python let &makeprg='pylint % -i y -r n -f parseable'
"autocmd BufWritePost *.py !python PythonTidy.py % %
"autocmd BufWritePost *.py e | syntax on
"autocmd BufWritePost *.js !fixjsstyle %
"autocmd BufWritePost *.js e | syntax on
"autocmd BufWritePost *.py,*.hx,*.js make
"autocmd BufWritePre *.py,*.js :%s/\s\+$//g
autocmd BufWritePost *.ccss !ccss %

" completion
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete

" as3
autocmd FileType actionscript setlocal omnifunc=actionscriptcomplete#CompleteAS
autocmd FileType actionscript setlocal dictionary+=$HOME/.vim/dict/actionscript.dict

" javascript
" au FileType javascript,coffee setlocal dictionary+=$HOME/.vim/dict/jscore.dict
au FileType javascript,coffee setlocal dictionary+=$HOME/.vim/dict/node.dict
" au FileType javascript,coffee set dictionary+=$HOME/.vim/dict/jQuery.dict

hi javaScriptFunction ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
" hi javaScriptFuncName ctermfg=141 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
" hi javaScriptRailsFunction ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
" hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

" autocmd FileType javascript,less,c,ruby,eruby,perl,tex,sass,scss,coffee,html,xhtml :setlocal tabstop=2 shiftwidth=2 softtabstop=2 shiftwidth=2
autocmd FileType actionscript setlocal noexpandtab

au BufRead,BufNewFile */etc/nginx/* setlocal ft=nginx
au BufRead,BufNewFile *.json setlocal ft=javascript

" jade
autocmd FileType jade setlocal commentstring=//-\ %s
autocmd FileType python setlocal commentstring=#\ %s
autocmd FileType nginx setlocal commentstring=#\ %s

" C/C++
au FileType c,cpp setlocal path+=/usr/local/include/**

" autocmd FileType jade setlocal sw=2
" au FileType javascript setlocal sw=2
" Project special config
" au BufRead,BufNewFile *.js setlocal sw=2
au BufRead,BufNewFile */ipub/*.js setlocal sw=4
au BufRead,BufNewFile */thel/*.js setlocal sw=2
au FileType go setlocal noexpandtab
au FileType go setlocal nolist
au FileType go setlocal nolist
au FileType go nmap gt :GoTest<CR>
au FileType go nmap gb :GoBuild<CR>
au FileType go nmap gc :GoCoverage<CR>
au FileType go nmap gs <Plug>(go-def-split)
au FileType go nmap gr :GoRename<CR>
au FileType go nmap gl :GoLint<CR>
au FileType go nmap ge :GoErrCheck<CR>
let g:go_fmt_command = "goimports"

" see http://vim.wikia.com/wiki/Automatically_append_closing_characters
function! SmartPairs(open, close, sp, brace)
  exec 'inoremap <buffer> ' . a:open . ' ' a:open . a:close . repeat('<left>', len(a:close))
  exec 'inoremap <buffer> ' . a:open . a:close . ' ' . a:open . a:close
  if(a:sp)
    exec 'inoremap <buffer> ' . a:open . ' ' a:open . '<space><space>' . a:close . repeat('<left>', len(a:close) + 1)
    exec 'inoremap <buffer> ' . a:open . '<space> ' a:open . '<space><space>' . a:close . repeat('<left>', len(a:close) + 1)
  endif
  if(a:brace)
    exec 'inoremap <buffer> ' . a:open . '<cr> ' a:open . '<cr>' . a:close . '<esc>O'
  endif
endf

function! SmartSimicolon()
  let l:str = getline('.')[col('.')-1:-1]
  if l:str =~ '^[ )}\]''"]*[''")\]]$'
    let b:lastSimLine = line('.')
    let b:lastSimCol = col('.')
    return "\<end>;"
  endif
  return ';'
endf

function! SmartBackspace()
  " char before cursor
  let l:chr = getline('.')[col('.')-2]
  let l:cidx = stridx('{([''"', l:chr)
  if l:cidx != -1
    " str after cursor
    let l:tail = getline('.')[col('.')-1:-1]
    " get right pair
    let l:rchr = '})]''"'[l:cidx]
    let l:idx = stridx(l:tail, l:rchr)
    if l:idx == 0 || l:tail[0:l:idx-1] =~ '^\s*$'
      " e.g. ({|  }) press <bs> at |, got (|), then got |
      return "\<bs>" . repeat("\<delete>", l:idx + 1)
    endif
  endif
  return "\<bs>"
endf

function! HtmlPairs()
  call SmartPairs('<%', '%>', 1, 0)
  call SmartPairs('<%=', '%>', 1, 0)
  call SmartPairs('{%', '%}', 1, 0)
  call SmartPairs('{%=', '%}', 1, 0)
endf

set nowrapscan
function! SmartSymbol()
  inoremap <buffer> ;; <end>;
  inoremap <buffer> <expr> ;<tab> getline('.')=~ '^\s*$' ? "\<esc>ddA;\<cr>" : "\<esc>jA;\<cr>"
  inoremap <buffer> ;<cr> <end>;<cr>
  inoremap <buffer> .<cr> <esc>j/)<cr>a.
  " inoremap <buffer> .<tab> <esc>/[\]})]<cr>a.<space>
  " inoremap <buffer> <expr> ,<cr> stridx(getline('.')[col('.')-1:-1], ')') != -1 ? "\<esc>f)i,\<space>" : "\<esc>j0f)i,\<space>"
  "TODO ,<tab> ,, integrated, find next )
  inoremap <buffer> ,<tab> <esc>/[\]})]<cr>a,<space>
  inoremap <buffer> ,, <esc>/['"\]})]<cr>a,<space>
endf

function! CommonPairs()
  call SmartPairs('(', ')', 0, 0)
  call SmartPairs('{', '}', 0, 1)
  call SmartPairs('[', ']', 0, 1)
  " call SmartPairs('/*', '*/', 1, 0)
  " call SmartPairs('/**', '*/', 1, 0)
  inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
  inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
  inoremap <expr> '  strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''\<Left>"
  inoremap <expr> "  strpart(getline('.'), col('.')-1, 1) == '"' ? "\<Right>" : '""<Left>'
  inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
  inoremap <buffer> <silent> /*<CR>  /*<CR>/<ESC>O
  inoremap <buffer> <silent> /**<CR>  /**<CR>/<ESC>O
  "inoremap <buffer> <silent> <expr> <buffer> ; SmartSimicolon()
  inoremap <buffer> <expr> <bs> SmartBackspace()
endf

function! AutocmdJS()
  call CommonPairs()
  call SmartSymbol()
  " comma start style
  " inoremap <buffer> ,<cr> <end><cr>,<space>
  " inoremap <buffer> , ,<SPACE>
  " inoremap <buffer> ,<SPACE> ,<SPACE>
  let &makeprg='gjslint --unix_mode --nojsdoc --ignore_errors 110,5,1,120 %'
  map <buffer> ff :!fixjsstyle --nojsdoc --ignore_errors 1,131 %<Enter>
endf

let g:SimpleJsIndenter_CaseIndentLevel=-0.5
"let g:SimpleJsIndenter_GreedyIndent=0

function! AutoPython()
    inoremap <buffer> ''' '''
    inoremap <buffer> """ """
endf

" au filetype c,cpp,python,ruby call CommonPairs()
" au filetype javascript call AutocmdJS()
" au filetype html call HtmlPairs()
" au filetype python call AutoPython()

