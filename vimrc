" See http://vimcdoc.sourceforge.net/doc/usr_41.html#usr_41.txt for vim script
" http://vimcdoc.sourceforge.net/doc/eval.html#functions
" http://stackoverflow.com/questions/1670983/getting-vim-to-be-efficient-in-actionscript-like-flex
" https://bitbucket.org/kuy/dotfiles

let mapleader = ","

" call pathogen to load the plugins
filetype off
let g:pathogen_disabled = ['neocomplete', 'snippets', 'snipmate-nodejs', 'mango', 'monokai']
call pathogen#infect()
filetype plugin indent on

" let g:PaperColor_Dark_Override = { 'background' : '#1c1c1c', 'cursorline' : '#abcdef', 'matchparen' : '#3a3a3a', 'comment' : '#5f875f' }
let g:PaperColor_Dark_Override = { 'background' : '#000000'}
let g:PaperColor_Light_Override = { 'background' : '#ffffff'}

" Command-T
let g:CommandTMatchWindowAtTop = 1
" ack
let s:ackcommand = executable('ack-grep') ? 'ack-grep' : 'ack'
" let g:ackprg=s:ackcommand." -H --nocolor --nogroup --column --ignore-dir node_modules --ignore-dir coverage.html --ignore-dir *-cov --ignore-dir out"
let g:ackprg=s:ackcommand." -H --nocolor --nogroup --column --ignore-dir bower_components --ignore-dir node_modules --ignore-dir coverage.html --ignore-dir lib-cov --ignore-dir out --ignore-dir deps --ignore-dir coverage --ignore-dir project.xcworkspace"

let g:acp_ignorecaseOption = 0
" You complete me. <TAB> for snipmate
let g:ycm_key_list_select_completion = ['<Down>'] " ['<TAB>', '<Down>']
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 0
" haxe
let g:vim_haxe_haxe_src_dir='/opt/haxe/'
" plugin settings
let g:tagbar_ctags_bin='/usr/local/bin/ctags'

" 自动关闭文档提示
" autocmd CompleteDone * pclose

set autowrite
" set noswapfile
set nocp nobackup nowritebackup
set complete+=k
set showcmd
set wildignore+=*bower_components/*,*node_modules/*,*.pyc,*coverage/*,*lib-cov/*,node_modules/*,deps/*,*/deps/*,*.jpg,*.gif,*.png,*.xcodeproj/*

" basic settings
set scrolloff=5
set background=dark

" Encoding
set nobomb
set encoding=utf-8
set fileformat=unix
"set fileformats=unix,dos,mac
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,cp963,gb18030,big5,euc-jp,euc-kr,latin1


set tabstop=4 " tab表示4个空格
set shiftwidth=4 " 缩进4个空格
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

set makeprg=make

" 以 >--- 显示制表符
set list
set listchars=tab:>-,trail:`

"colo slate
"colo torte
"colo yerik_night
"colo moria
"colo wombat
"colo wombat256mod

let g:solarized_termcolors=256
" colo solarized
" colo lucius
colo mymolokai
if $COLO=='light'
    colo github
    hi SpecialKey   guifg=#FFFFFF ctermfg=231  guibg=#FFDDDD ctermbg=224  gui=NONE cterm=NONE
    hi Todo         guifg=#F8F8FF ctermfg=231  guibg=#FFFF66 ctermbg=227  gui=UNDERLINE cterm=UNDERLINE
endif
" colo bubblegum
if has('gui_running')
    set guioptions=mr
    if has('win32') || has('macunix')
        set lines=48
        set columns=240
        " colo lucius
        hi normal guibg=black
        set transp=9
        "set guifont=Monaco:h11:w6
        set guifont=Monaco:h12
    else " linux
        set guifont=Monospace:h9:w5
    endif
else
    " colo mango
endif
set vb
set t_Co=256

" autocmd ColorScheme * highlight Folded guibg=#00 guifg=green
" autocmd ColorScheme * highlight FoldColumn guibg=darkgrey guifg=white
hi Folded guibg=NONE guifg=#666666
hi Folded ctermbg=NONE ctermfg=yellow


if (v:version>=703)
    hi ColorColumn ctermbg=236 guibg=#303030
    " set colorcolumn=80,100
endif

"set cuc
"set cul

" map
nmap <F6> <Plug>DiffChangesDiffToggle
nmap <F7> <Plug>DiffChangesPatchToggle
" insert maps
imap <c-o> <esc>o
imap <buffer> <s-bs> <del>
imap <D-k> <c-x><c-k>
" Tabularzie, alignment
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
" align the word after colon
"nmap <Leader>a: :Tabularize /:\zs<CR>
"vmap <Leader>a: :Tabularize /:\zs<CR>

" vmap <leader>v :s/; *\n\( *\)var /\r\1  , /I<cr>
vmap <leader>v :s/, *\n\(\s*\)\(\S[^,]*\)/\r\1, \2/I<cr>

nmap <Leader>cl :set nonumber<CR>:set background=light<CR>:colo PaperColor<CR>:CopyRTF<CR>:colo mymolokai<CR>:set number<CR>:set background=dark<CR>
nmap <Leader>cc :set nonumber<CR>:CopyRTF<CR>:set number<CR>

" window maps
nmap <leader>h <C-W>h
nmap <leader>j <C-W>j
nmap <leader>k <C-W>k
nmap <leader>l <C-W>l

" arrow key map
" Because dot register preservation code remaps escape we have to remap
" some terminal specific escape sequences first
if &term =~ 'xterm' || &term =~ 'rxvt' || &term =~ 'screen' || &term =~ 'linux' || &term =~ 'gnome'
    imap <silent> <Esc>OA <Up>
    imap <silent> <Esc>OB <Down>
    imap <silent> <Esc>OC <Right>
    imap <silent> <Esc>OD <Left>
    imap <silent> <Esc>OH <Home>
    imap <silent> <Esc>OF <End>
    imap <silent> <Esc>[5~ <PageUp>
    imap <silent> <Esc>[6~ <PageDown>
endif

" mouse map
map <MouseDown> <C-y>
map <S-MouseDown> <C-u>
map <MouseUp> <C-e>
map <S-MouseUp> <C-d>

" clipboard map
nmap <leader>p "+P
vmap <leader>y "+y

" save map
map <C-s> :w<CR>
nmap w :w<CR>
"autocmd BufWritePre * :%s/\s*$//

nnoremap gf :vertical wincmd f<CR>

" TaskList (work)
nmap <unique> <leader>w <Plug>TaskList

" goto
nnoremap <unique> <silent> <Leader>g :CommandTFlush<CR>:CommandT<CR>
nnoremap <unique> <silent> <Leader>s :split<CR>:CommandTFlush<CR>:CommandT<CR>
nnoremap <unique> <silent> <Leader>v :vsplit<CR>:CommandTFlush<CR>:CommandT<CR>
" buffer
nnoremap <unique> <silent> <Leader>b :CommandTBuffer<CR>

" NERDTree toggle
"nnoremap <leader>f :NERDTreeFIND<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
" NETRW
nnoremap <leader>e :Explore<CR>
" taglist
nnoremap <leader>t :TagbarToggle<CR>
" <CR> close completion menu
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
" inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
