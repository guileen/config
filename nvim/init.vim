""""""""""""""""""""""""
"         Plug         "
""""""""""""""""""""""""
" https://github.com/junegunn/vim-plug
" :PlugUpgrade to upgrade vim-plug itself
" :PlugInstall to install
" :PlugInstall! to force reinstall
" :PlugUpdate to update
call plug#begin('~/.vim/plugged')
" Editor Basic

" Multi cursor
Plug 'terryma/vim-multiple-cursors'
" Surround motion cs ds
Plug 'tpope/vim-surround'
" Find and replace
Plug 'dyng/ctrlsf.vim'
" Goto file
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'kien/ctrlp.vim', {'on': ['CtrlP', 'CtrlPMixed']}
" close pair () {} 
Plug 'Raimondi/delimitMate'   " ( ) { } .e.g
Plug 'scrooloose/nerdcommenter' " [count]<leader> cc cn c<space> cm ci cs cy c$ cA cl cb cu
Plug 'editorconfig/editorconfig-vim'  " put .editorconfig in your root directory

" Git support
Plug 'tpope/vim-fugitive'

" Syntax checker
"Plug 'vim-syntastic/syntastic'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --js-completer --go-completer'}  " Put .ycm_extra_conf.py in any folder above you file

" For tagbar
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" For javascript
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim'

Plug 'dag/vim-fish', { 'for': 'fish'}

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
" Go to file
nmap <leader>g :FZF<CR>
"nmap <leader>g :CtrlPMixed<CR>


""""""""""""""""""""""""
"   Plugins Settings   "
""""""""""""""""""""""""
" delimitMate
let delimitMate_expand_cr = 1

" YCM
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion= 1
nnoremap <leader>r :YcmCompleter GoTo<CR>
nnoremap gd :YcmCompleter GoTo<CR>

" CtrlSF
"Find selected word
vmap <leader>f <Plug>CtrlSFVwordExec
"Find word in cursor
"nmap <leader>f <Plug>CtrlSFCwordPath
"Find word in cursor with boundary
nmap <leader>f <Plug>CtrlSFCCwordPath<CR>

" Tagbar
nmap <leader>t :TagbarToggle<CR>
