let g:syntastic_javascript_checkers = ['eslint']

" setlocal dictionary+=$HOME/.vim/dict/jscore.dict
setlocal dictionary+=$HOME/.vim/dict/node.dict
nnoremap <leader>f :w<CR>:!eslint --fix %<CR>
hi javaScriptFunction ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
