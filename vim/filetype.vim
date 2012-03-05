" as3
autocmd FileType actionscript set omnifunc=actionscriptcomplete#CompleteAS
autocmd FileType actionscript set dictionary+=$HOME/.vim/dict/actionscript.dict

" javascript
au FileType javascript set dictionary+=$HOME/.vim/dict/javascript.dict
au FileType javascript set dictionary+=$HOME/.vim/dict/node.dict

autocmd FileType javascript,less,c,ruby,eruby,perl,tex,sass,scss,coffee,html,xhtml setlocal tabstop=2 shiftwidth=2 softtabstop=2 shiftwidth=2
autocmd FileType actionscript setlocal noexpandtab

au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile *.json set ft=javascript

" C/C++
au FileType c,cpp set path+=/usr/local/include/**
