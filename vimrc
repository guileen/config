
" call pathogen to load the plugins
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set scrolloff=5

set nocp
set nobackup
set nowritebackup
set background=dark

" Encoding
set nobomb
set encoding=utf-8
set fileformat=unix
"set fileformats=unix,dos,mac
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,cp963,gb18030,big5,euc-jp,euc-kr,latin1


set tabstop=4 " tab表示4个空格
set shiftwidth=2 " 缩进2个空格
set expandtab " 自动将tab展开成空格
set softtabstop=0 " 删除空格缩进
set smarttab " 行首按tab将自动转换为空格
set backspace=indent,eol,start  " more powerful backspacing
set history=200
set ruler
set number

"set nohls " no search results highlight

" Status Line
set laststatus=2
"set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L:%c:

set statusline=CWD:\ %r%{getcwd()}%h\ \ %F%m%r%h\ %w\ \ \ Line:\ %l/%L:%c:

syntax on
set autoindent
set cindent
set smartindent
filetype plugin on
filetype indent on

"colo slate
"colo torte
colo lucius
"colo yerik_night
"colo moria
"colo wombat
"colo wombat256mod
if has('gui_running')
    set guioptions=mr
    if has('win32') || has('macunix')
        set guifont=Monaco:h9:w5
        set lines=40
        set columns=200
    else " linux
        set guifont=Monospace:h9:w5
    endif
endif

set t_Co=256

if (v:version>=703)
    hi ColorColumn ctermbg=236 guibg=#303030
    "set colorcolumn=4,8,12,16,20,24,28,32,36,40,44,48,52,56,60,80,100
    set colorcolumn=80,100
endif

"set cuc
"set cul

" 以 >--- 显示制表符
set list
set listchars=tab:>-,trail:`
"hi SpecialKey guifg=#3a3a3a ctermfg=237

map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

map <MouseDown> <C-y>
map <S-MouseDown> <C-u>
map <MouseUp> <C-e>
map <S-MouseUp> <C-d>

map <C-s> :w<CR>
" NERDTree toggle
nnoremap <F11> :NERDTreeToggle<CR>
" taglist
nnoremap <F12> :TlistToggle<CR>


"indent color
"hi 4spa guibg = #771144
"hi 8spa guibg = #22464A
"hi 12spa guibg = #344333
"hi 16spa guibg = #777444
"hi 20spa guibg = #555777
"hi 24spa guibg = #cc9966
"hi 80spa guibg = #ff1111
""style 1
"syn match 4spa /\(\s\{4}\|\n\)\&\%1v.*\%2v/
"syn match 8spa /\s\{4}\&\%5v.*\%6v/
"syn match 12spa /\s\{4}\&\%9v.*\%10v/
"syn match 16spa /\s\{4}\&\%13v.*\%14v/
"syn match 20spa /\s\{4}\&\%17v.*\%18v/
"syn match 24spa /\s\{4}\&\%21v.*\%22v/
"style 2
"syn match 4spa /\(\s\|\n\)\&\%4v.*\%5v/
"syn match 8spa /\s\&\%8v.*\%9v/
"syn match 12spa /\s\&\%12v.*\%13v/
"syn match 16spa /\s\&\%16v.*\%17v/
"syn match 20spa /\s\&\%20v.*\%21v/
"syn match 24spa /\s\&\%24v.*\%25v/
"syn match 80spa /.\&\%80v.*\%81v/


" delmitMate
"let g:delimitMate_autoclose = 1

" miniBufferExplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1



""""""""""""""""""""""""""""""""""""""""""""""
"               NeoComplCache                "
""""""""""""""""""""""""""""""""""""""""""""""

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = { 
            \ 'javascript' : '~/.vim/dict/javascript.dict'
            \ }
"            \ 'default' : '', 
"    'vimshell' : $HOME.'/.vimshell_hist',
"    'scheme' : $HOME.'/.gosh_completions',

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . (&indentexpr != '' ? "\<C-f>\<CR>X\<BS>":"\<CR>")
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType actionscript set omnifunc=actionscriptcomplete#CompleteAS

" dictionary setting
if has('win32')
    autocmd FileType actionscript :set dictionary=$HOME/vimfiles/dict/actionscript.dict
    autocmd FileType javascript :set dictionary=$HOME/vimfiles/dict/javascript.dict
else
    autocmd FileType actionscript :set dictionary=$HOME/.vim/dict/actionscript.dict
    autocmd FileType javascript :set dictionary=$HOME/.vim/dict/javascript.dict
endif

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

autocmd BufRead *.as set filetype=actionscript
autocmd BufRead *.mxml set filetype=mxml
autocmd BufRead *.hx set filetype=haxe
autocmd BufRead *.ccss set filetype=clevercss
autocmd BufRead *.js,*.jade,*.haml,*.html set shiftwidth=2
autocmd BufRead *.md,*.markdown noremap <F8> :Mm<Enter>
autocmd BufRead *.coffee noremap <F8> :!coffee -p %<Enter>
autocmd BufRead *.htm,*.html noremap <F8> :!google-chrome %<Enter>

let g:vim_haxe_haxe_src_dir='/opt/haxe/'

set makeprg=make

autocmd FileType python let &makeprg='pylint % -i y -r n -f parseable'
autocmd FileType javascript let &makeprg='gjslint --unix_mode --nojsdoc %'
autocmd FileType javascript map # 0I//<Esc>
autocmd FileType javascript map ff :!fixjsstyle %<Enter>
autocmd FileType javascript,coffee set shiftwidth=2
autocmd FileType javascript let g:SimpleJsIndenter_CaseIndentLevel=-1

"autocmd BufWritePost *.py !python PythonTidy.py % %
"autocmd BufWritePost *.py e | syntax on
"autocmd BufWritePost *.js !fixjsstyle %
"autocmd BufWritePost *.js e | syntax on
"autocmd BufWritePost *.py,*.hx,*.js make
autocmd BufWritePost *.ccss !ccss %

nmap <F6> <Plug>DiffChangesDiffToggle
nmap <F7> <Plug>DiffChangesPatchToggle

"set foldclose=all
