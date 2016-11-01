" Using vimplug
"
" Run inside vim
" :PlugInstall
"
" Rafael HT. 2016 - http://fael.nl
"

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'rhysd/vim-clang-format'
Plug 'easymotion/vim-easymotion'
Plug 'JuliaLang/julia-vim'
Plug 'bling/vim-airline'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
call plug#end()

syntax on
set laststatus=2
filetype plugin indent on
set expandtab
set ts=2
set shiftwidth=2
set cc=80
set encoding=utf-8
set number
color molokai

let mapleader=","

imap <Tab><Tab> <Esc>
map <leader><space> :nohl<cr>
map <silent> <leader>c :ClangFormat<cr>
map <leader>q :xa<cr>
map <leader>s :sh<cr>

"" NERDTree configuration
let g:NERDTreeChDirMode=1
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 20
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>

" EasyMotion
hi EasyMotionTarget ctermbg=none ctermfg=green
hi EasyMotionShade ctermbg=none ctermfg=blue
hi EasyMotionTarget2First ctermbg=none ctermfg=red
hi EasyMotionTarget2Second ctermbg=none ctermfg=darkblue
hi EasyMotionMoveHL ctermbg=green ctermfg=black

set shell=/usr/bin/fish
set mouse=n

let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'

let g:airline_powerline_fonts=1
