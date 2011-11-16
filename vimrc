" See http://vimcdoc.sourceforge.net/doc/usr_41.html#usr_41.txt for vim script
" http://vimcdoc.sourceforge.net/doc/eval.html#functions
" http://stackoverflow.com/questions/1670983/getting-vim-to-be-efficient-in-actionscript-like-flex
" https://bitbucket.org/kuy/dotfiles
let mapleader = ","

" call pathogen to load the plugins
filetype off
let g:pathogen_disabled = ['vim-autoclose']
call pathogen#infect()
filetype plugin indent on

set nocp nobackup nowritebackup
set complete+=k

" insert maps
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
  inoremap <buffer> .<tab> <esc>/[\]})]<cr>a.<space>
  " inoremap <buffer> <expr> ,<cr> stridx(getline('.')[col('.')-1:-1], ')') != -1 ? "\<esc>f)i,\<space>" : "\<esc>j0f)i,\<space>"
  "TODO ,<tab> ,, integrated, find next )
  inoremap <buffer> ,<tab> <esc>/[\]})]<cr>a,<space>
  inoremap <buffer> ,, <esc>/['"\]})]<cr>a,<space>
endf

function! CommonPairs()
  call SmartPairs('"', '"', 0, 0)
  call SmartPairs("'", "'", 0, 0)
  call SmartPairs('(', ')', 0, 0)
  call SmartPairs('{', '}', 0, 1)
  call SmartPairs('[', ']', 0, 1)
  " call SmartPairs('/*', '*/', 1, 0)
  " call SmartPairs('/**', '*/', 1, 0)
  inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
  inoremap <buffer> <silent> /*<CR>  /*<CR>/<ESC>O
  inoremap <buffer> <silent> /**<CR>  /**<CR>/<ESC>O
  "inoremap <buffer> <silent> <expr> <buffer> ; SmartSimicolon()
  inoremap <buffer> <expr> <bs> SmartBackspace()
endf

function! AutocmdJS()
  call CommonPairs()
  call SmartSymbol()
  " comma start style
  inoremap <buffer> ,<cr> <end><cr>,<space>
  " inoremap <buffer> , ,<SPACE>
  " inoremap <buffer> ,<SPACE> ,<SPACE>
  inoremap <buffer> $<Tab> $("")<left><left>
  inoremap <buffer> $( $("")<left><left>
  let &makeprg='gjslint --unix_mode --nojsdoc %'
  map ff :!fixjsstyle %<Enter>
  let g:SimpleJsIndenter_CaseIndentLevel=-1
  "let g:SimpleJsIndenter_GreedyIndent=0
endf

au filetype javascript call AutocmdJS()
au filetype html call HtmlPairs()

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



" ack on the fly
nnoremap <leader>a :Ack  <bs>

" TaskList
map <unique> <leader>l <Plug>TaskList

" Command-T
nnoremap <unique> <silent> <Leader>t :CommandT<CR>
nnoremap <unique> <silent> <Leader>b :CommandTBuffer<CR>

" NERDTree toggle
nnoremap <leader>f :NERDTreeToggle<CR>
" taglist
nnoremap <leader>g :TagbarToggle<CR>

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
