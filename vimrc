
" call pathogen to load the plugins
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" insert maps
" see http://vim.wikia.com/wiki/Automatically_append_closing_characters
function! SmartPairs(open, close)
  exec 'inoremap ' . a:open . ' ' a:open . a:close . repeat('<left>', len(a:close))
  exec 'inoremap ' . a:open . '<space> ' a:open . '<space><space>' . a:close . repeat('<left>', len(a:close) + 1)
  exec 'inoremap ' . a:open . '<cr> ' a:open . '<cr>' . a:close . '<esc>O'
  exec 'inoremap ' . a:open . a:close . ' ' . a:open . a:close
endf

function! CommonPairs()
  call SmartPairs('"', '"')
  call SmartPairs("'", "'")
  call SmartPairs('(', ')')
  call SmartPairs('{', '}')
  call SmartPairs('[', ']')
  call SmartPairs('/*', '*/')
  call SmartPairs('/**', '*/')
  inoremap /*<CR>  /*<CR>/<ESC>O
  inoremap /**<CR>  /**<CR>/<ESC>O
endf

function! AutocmdJS()
  call CommonPairs()
  inoremap , ,<SPACE>
  inoremap : <SPACE>:<SPACE>
  inoremap $<Tab> $("")<left><left>
  inoremap $( $("")<left><left>
  let &makeprg='gjslint --unix_mode --nojsdoc %'
  map # 0I//<Esc>
  map ff :!fixjsstyle %<Enter>
  set shiftwidth=2
  let g:SimpleJsIndenter_CaseIndentLevel=-1
endf

au filetype javascript call AutocmdJS()

"autocmd BufWritePre * :%s/\s*$//

" window maps
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
nnoremap <C-n> :NERDTreeToggle<CR>
" taglist
nnoremap <F12> :TagbarOpenAutoClose<CR>
nnoremap <C-m> :TagbarToggle<CR>

" plugin settings
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
"let g:AutoClosePairs=AutoClose#ParsePairs("() [] {} ` \" '")

" basic settings
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
"autocmd BufWritePost *.py !python PythonTidy.py % %
"autocmd BufWritePost *.py e | syntax on
"autocmd BufWritePost *.js !fixjsstyle %
"autocmd BufWritePost *.js e | syntax on
"autocmd BufWritePost *.py,*.hx,*.js make
autocmd BufWritePost *.ccss !ccss %

nmap <F6> <Plug>DiffChangesDiffToggle
nmap <F7> <Plug>DiffChangesPatchToggle

"set foldclose=all
