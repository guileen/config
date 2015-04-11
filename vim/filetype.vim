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

autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete

" as3
autocmd FileType actionscript setlocal omnifunc=actionscriptcomplete#CompleteAS
autocmd FileType actionscript setlocal dictionary+=$HOME/.vim/dict/actionscript.dict

" javascript
au FileType javascript,coffee setlocal dictionary+=$HOME/.vim/dict/jscore.dict
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

autocmd FileType jade setlocal sw=2
au FileType javascript setlocal sw=2
" Project special config
au BufRead,BufNewFile *.js setlocal sw=2
au BufRead,BufNewFile */ipub/*.js setlocal sw=4
au FileType go setlocal noexpandtab
au FileType go setlocal nolist
au FileType go setlocal nolist
au FileType go nmap gt :GoTest<CR>
au FileType go nmap gb :GoBuild<CR>
au FileType go nmap gc :GoCoverage<CR>
au FileType go nmap gr :GoRename<CR>
au FileType go nmap gl :GoLint<CR>
au FileType go nmap ge :GoErrCheck<CR>
let g:go_fmt_command = "goimports"



" -------------- neocomplete
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
