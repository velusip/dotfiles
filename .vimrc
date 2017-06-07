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
" line numbers
set relativenumber
" move by virtual lines, except when using a count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" indent
set backspace=indent,eol,start  " powerful backspacing
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set cindent
set cinkeys-=0#
set indentkeys-=0#
" fold
set foldmethod=marker
set foldlevel=99
" colour
filetype plugin indent on
syntax on
set hlsearch
if has('gui_running')
    set background=light
endif
hi ColorColumn ctermbg=magenta
hi User1 ctermbg=darkcyan ctermfg=black
" show 80-column breach
call matchadd('ColorColumn', '\%81v', 100)
" status bar
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
" paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
if has('gui_running')
    " Make shift-insert work like in Xterm
    map <S-Insert> <MiddleMouse>
    map! <S-Insert> <MiddleMouse>
endif
" window split: <Ctrl+w><v>ertical, <Ctrl+w><s>upine, <Ctrl+w><q>uit, <Ctrl+w><[hjkl]>
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l
nmap <c-h> <c-w>h
" tab manipulation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
" visual block <C-v> dragging (used with Ctrl+v)
vmap <expr> <S-LEFT> DVB_Drag('left')
vmap <expr> <S-RIGHT> DVB_Drag('right')
vmap <expr> <S-DOWN> DVB_Drag('down')
vmap <expr> <S-UP> DVB_Drag('up')
vmap <expr> D DVB_Duplicate()
