set nocompatible    " establishing the default... ahem
set regexpengine=1
set history=50
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set backupdir=~/tmp,.
set directory=~/tmp,.
set showcmd
set showmatch
set wildmenu
set wildmode=longest:full,full
set nonumber

" #### indent
set backspace=indent,eol,start  " powerful backspacing
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

" #### fold
set foldmethod=marker
set foldlevel=99
" #### window split
"  vertical <Ctrl+w> + <v>
"horizontal <Ctrl+w> + <s>
"      move <Ctrl+w> + <[hjkl]>
"     close <Ctrl+w> + <q>
"Optionally map out the w:
"map <c-j> <c-w>j
"map <c-k> <c-w>k
"map <c-l> <c-w>l
"map <c-h> <c-w>h

" #### colour
filetype plugin indent on
syntax on
set hlsearch
if has('gui_running')
    set background=light
endif
hi ColorColumn ctermbg=magenta
hi User1 ctermbg=darkcyan ctermfg=black
" #### show 80-column breach
call matchadd('ColorColumn', '\%81v', 100)
" #### status bar
set noruler                   "hide, using statusline instead
set laststatus=2              "always show
set statusline=
set statusline+=%1*%n\ %*      "current buffer
set statusline+=%1*%{&ff}%*      "file format
set statusline+=%1*%y%*          "file type detected
set statusline+=%1*\ %<%F%*      "full path
set statusline+=%1*%m%*          "modified[+]
set statusline+=%1*%=%5l%*       "current row
set statusline+=%1*/%L%*         "/total rows
set statusline+=%1*%4v\ %*       "current column
set statusline+=%1*0x%04B\ %*    "character under cursor



" #### paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
if has('gui_running')
    " Make shift-insert work like in Xterm
    map <S-Insert> <MiddleMouse>
    map! <S-Insert> <MiddleMouse>
endif

" #### digraphs
" inoremap <expr>  <C-K>   HUDG_GetDigraph()
inoremap <expr> <C-K> ShowDigraphs()
function! ShowDigraphs ()
    digraphs
    call getchar()
    return "\<C-K>"
endfunction

" #### visual block <C-v> dragging
vmap <expr> <S-LEFT> DVB_Drag('left')
vmap <expr> <S-RIGHT> DVB_Drag('right')
vmap <expr> <S-DOWN> DVB_Drag('down')
vmap <expr> <S-UP> DVB_Drag('up')
vmap <expr> D DVB_Duplicate()

