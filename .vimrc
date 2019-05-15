" Tom Zurita 2017

"""""""""""""""""""""""""""""""""""
" VIM PLUG SETUP and some downloads
" http://vimawesome.com/
"""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
call plug#begin('~/.vim/plugged')
" Plugins - General
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'christoomey/vim-tmux-navigator'
" Plugins - Syntax
Plug 'pearofducks/ansible-vim'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-markdown'
" Plugins for Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
" Plugins for Look
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
" Plugins for Programming
Plug 'jiangmiao/auto-pairs'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'aperezdc/vim-template'
call plug#end()

""""""""""""""""""""""""
" Setup plugins settings
""""""""""""""""""""""""
syntax enable
syntax on

" Theme setup
if (has("autocmd") && !has("gui_running"))
    augroup colorset
        autocmd!
        let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7"  }
        autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white  }) " `bg` will not be styled since there is no `bg` setting
    augroup END
endif

let g:rehash256 = 1
silent! colorscheme onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

" Plugin - Ansible Vim
let g:ansible_unindent_after_newline = 1
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile */plays/*.yml set filetype=yaml.ansible

" Plugin - CntrlP
noremap <C-x> :CtrlP ~/QI<CR>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" Plugin - Jedi
"let g:jedi#popup_on_dot = 0

" Plugin - NERDtree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Plugin - Supertab
let g:SuperTabDefaultCompletionType = "context"

" Plugin - Syntastic
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_xml_checkers = ['xmllint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_quiet_messages = { "type": "style" }

" Plugin - Tabular
" Only tabularize the first =
map <S-1> :Tabularize /^[^=]*\zs=<cr>
" Align all the , in alist of dicts or tupples
map <S-2> :Tabularize /,\zs<cr>
" Tabularize elements of a dict
map <S-3> :Tabularize /:\zs<cr>

" Plugin - VimTemplates
let g:email = 'tzurita@gmail.com'

" Plugin - Utilsnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsListSnippets="<s-tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"

""""""""""""""""""""
" My hacks
""""""""""""""""""""
" My leader key
let mapleader=","
let maplocalleader = "\\"

" Remove trailing spaces
nnoremap <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Save and run the current script
nmap <F5> :w<CR> :! ./%<CR>

set autoindent
set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp
set encoding=utf-8
set expandtab
set foldlevel=99
set hlsearch
set incsearch
set ignorecase
set list
set listchars=tab:▶\ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣
set noerrorbells
set novisualbell
set nowrap
set number
set relativenumber
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set smarttab
set textwidth=0
set virtualedit=all
set wildignore=*.swp,*.bak,*.pyc,*.class
set ttyfast

" Remove highlights with leader + enter
nmap <Leader><CR> :nohlsearch<cr>
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

command! Q  quit
command! W  write
command! Wq wq

""""""""""""""""""
" Filetypes
""""""""""""""""""
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on
set equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
autocmd BufRead,BufNewFile *.tex set spell

""""""""""""""""""""""""""""""""""""""""""""""""""
" Some Colors
""""""""""""""""""""""""""""""""""""""""""""""""""
hi Visual ctermbg=blue

" when we reload, tell vim to restore the cursor to the saved position
""""""""""""""""""""""""""""""""""""""""""""""""""
" Tell vim to remember certain things when we exit
" http://vim.wikia.com/wiki/VimTip80
""""""""""""""""""""""""""""""""""""""""""""""""""
set viminfo='10,\"100,:20,%,n~/.viminfo
" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif

 autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_us

augroup XML
    autocmd!
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
    autocmd FileType xml :syntax on
    autocmd FileType xml :%foldopen!
augroup END
