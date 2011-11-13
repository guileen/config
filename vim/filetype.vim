" as3
autocmd FileType actionscript set omnifunc=actionscriptcomplete#CompleteAS
autocmd FileType actionscript :set dictionary=$HOME/.vim/dict/actionscript.dict

autocmd FileType javascript,less,c,ruby,eruby,perl,tex,sass,scss,coffee,html,xhtml \
    setlocal tabstop=2 shiftwidth=2 softtabstop=2 shiftwidth=2

