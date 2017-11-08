let g:syntastic_javascript_checkers = ['eslint']

" au FileType javascript,coffee setlocal dictionary+=$HOME/.vim/dict/jscore.dict
au FileType javascript,coffee setlocal dictionary+=$HOME/.vim/dict/node.dict
au FileType JavaScript nnoremap <leader>f :w<CR>:!eslint --fix %<CR>
hi javaScriptFunction ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
