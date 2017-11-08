""""""""""""""""""""""""
"         Plug         "
""""""""""""""""""""""""
" https://github.com/junegunn/vim-plug
" :PlugUpgrade to upgrade vim-plug itself
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --js-completer --go-completer'}  " Put .ycm_extra_conf.py in any folder above you file
Plug 'editorconfig/editorconfig-vim'  " put .editorconfig in your root directory
Plug 'Raimondi/delimitMate'   " ( ) { } .e.g
Plug 'scrooloose/nerdcommenter' " [count]<leader> cc cn c<space> cm ci cs cy c$ cA cl cb cu
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
call plug#end()
set rtp+=/usr/local/opt/fzf " installed fzf with homebrew"


""""""""""""""""""""""""
"     vim Settings     "
""""""""""""""""""""""""
syntax on
set nocp nobackup nowritebackup
set backspace=indent,eol,start  " more powerful backspacing
set number
set tabstop=4
set shiftwidth=4

colo mymolokai

""""""""""""""""""""""""
"     Key Mapping      "
""""""""""""""""""""""""
let mapleader = ","
" window maps
nmap <leader>h <C-W>h
nmap <leader>j <C-W>j
nmap <leader>k <C-W>k
nmap <leader>l <C-W>l
" clipboard map
nmap <leader>p "+P
vmap <leader>y "+y
" save map
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>wq :wq<CR>
" NETRW
nnoremap <leader>e :Explore<CR>
nmap <leader>g :FZF<CR>

""""""""""""""""""""""""
"         YCM          "
""""""""""""""""""""""""
let g:ycm_confirm_extra_conf = 0
nnoremap <leader>r :YcmCompleter GoTo<CR>

