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
"autocmd BufWritePost *.js :!eslint --fix %
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
au FileType JavaScript nnoremap <leader>f :w<CR>:!eslint --fix %<CR>
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
