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
"Plug 'kien/ctrlp.vim', {'on': ['CtrlP', 'CtrlPMixed']}
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
" close pair () {} 
"Plug 'Raimondi/delimitMate'   " ( ) { } .e.g
Plug 'jiangmiao/auto-pairs'

Plug 'scrooloose/nerdcommenter' " [count]<leader> cc cn c<space> cm ci cs cy c$ cA cl cb cu
Plug 'editorconfig/editorconfig-vim'  " put .editorconfig in your root directory

" Git support
"Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax checker
"Plug 'vim-syntastic/syntastic'

"Completion
"Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" For tagbar
Plug 'liuchengxu/vista.vim'

" For Status line
Plug 'liuchengxu/eleline.vim'

" All in one highlight
Plug 'sheerun/vim-polyglot'

call plug#end()

set rtp+=/usr/local/opt/fzf " installed fzf with homebrew"

""""""""""""""""""""""""
"     vim Settings     "
""""""""""""""""""""""""
syntax on
set nocp nobackup nowritebackup
set backspace=indent,eol,start  " more powerful backspacing
set number
" Tab
set tabstop=4
set shiftwidth=4
set noexpandtab " 自动将tab展开成空格
" 以 \t.. 显示制表符
set list
"»···»··· ·»»»·»»» —–––—––– ·›››·›››
"»›››»››› ·–––·––– ›–––›––– –›››–›››
set listchars=tab:»·,trail:¬,nbsp:_

" Folding
set nofoldenable
set foldminlines=10
set foldnestmax=3

" Split
set splitbelow
set splitright

" Enable mouse drag
set mouse=nv

set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

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
nnoremap q :q<CR>
" NETRW
nnoremap <leader>e :Explore<CR>
" Go to file
"nmap <leader>g :FZF<CR>
"nmap <leader>g :CtrlPMixed<CR>
nmap <leader>g :Clap files<CR>
nmap <leader>o :Clap filer<CR>
" Search selelcted
vnoremap / y/<C-R>"
" Toggle search highlight
nnoremap <leader>xh :set hlsearch! hlsearch?<CR>

" Terminal
nnoremap <leader>sh :vsplit term://fish<CR>:vertical resize 30<CR>i
vnoremap <leader>? y:vsplit term://fy <C-R>"<CR>:vertical resize 30<CR>
:tnoremap <Esc> <C-\><C-N>


""""""""""""""""""""""""
"   Plugins Settings   "
""""""""""""""""""""""""
" delimitMate
let g:delimitMate_expand_cr = 2
let g:delimitMate_backspace = 1


" AutoPair
" ( conflict with CompleteParameter
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
"inoremap <buffer> <silent> ) <C-R>=AutoPairsInsert(')')<CR>

" CtrlSF
"Find selected word
vmap <leader>fd <Plug>CtrlSFVwordExec
"Find word in cursor
"nmap <leader>f <Plug>CtrlSFCwordPath
"Find word in cursor with boundary
nmap <leader>fd <Plug>CtrlSFCCwordPath<CR>

" Tagbar
nmap <leader>t :Vista coc<CR>

" Coc
inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>qf  <Plug>(coc-fix-current)

"inoremap <silent><expr> <C-i> coc#refresh()
"inoremap <silent><expr> <A-/> coc#refresh()


nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>
