" velu's .vimrc
" #### visual preferences ######################################################
" #### colourizing
set background=light
" #### hi-lighting
syntax on
filetype on
filetype plugin indent on
" #### indenting
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
" #### paste indenting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
" #### screen management -- folding
set foldmethod=indent
set foldlevel=99
" #### screen management -- split window
"  vertical <Ctrl+w> + <v>
"horizontal <Ctrl+w> + <s>
"      move <Ctrl+w> + <[hjkl]>
"     close <Ctrl+w> + <q>
"Optionally map out the w:
"map <c-j> <c-w>j
"map <c-k> <c-w>k
"map <c-l> <c-w>l
"map <c-h> <c-w>h










" #### Bundles
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
Bundle "pangloss/vim-javascript"


filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
