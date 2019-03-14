runtime! plugin/sensible.vim

" Vundle
set nocompatible " required by Vundle
filetype off     " required by Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'eugen0329/vim-esearch'
Plugin 'gmarik/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'machakann/vim-highlightedyank'
Plugin 'markonm/traces.vim'
Plugin 'romainl/vim-cool'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'w0ng/vim-hybrid'
Plugin 'yegappan/greplace'
Plugin 'Yggdroot/indentLine'
call vundle#end()
filetype plugin indent on " required by Vundle

" Set leader key
let mapleader = ","

" Fix alt keys
execute "set <M-j>=\ej"
nnoremap <M-j> j
execute "set <M-k>=\ek"
nnoremap <M-k> k

" Normal bindings
nnoremap j gj
nnoremap k gk

" Shift lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" leader bindings
nnoremap <leader>vr :tabe $MYVIMRC<CR>
nnoremap <leader>so :source $MYVIMRC<CR>
nnoremap <silent> <leader>pa :setlocal paste<CR>"+p :setlocal nopaste<CR>

" tags
nnoremap <C-]> :exec("tag ".expand("<cword>"))<CR>
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <C-[> :split <CR>:exec("tag ".expand("<cword>"))<CR>
nunmap <Esc>

let loaded_netrwPlugin = 1

" ctrlP
let g:ctrlp_use_caching = 0
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

set regexpengine=1 " Use old regex engine which is way faster with Ruby
set nocompatible " Don't maintain compatibility with Vi
set splitright
set splitbelow
set t_Co=256 " 256 color terminal
set autoread " Load file from disk, ie for git reset
set backspace=indent,eol,start " Sane backspace behavior
set history=1000 " Remember last 1000 commands
set scrolloff=4 " Keep at least 4 lines around cursor
set expandtab " Convert <tab> to spaces (2 or 4)
set tabstop=2 " Two spaces per tab as default
set shiftwidth=2 "   then override with per filetype
set softtabstop=2 "   specific settings via autocmd
set secure " Limit what modelines and autocmds can do
set autowrite " Write for me when I take any action
set ruler " Show cursor position all the time
set cursorline
set breakindent
set showmatch
set nowrap
set smarttab
set hlsearch
set ignorecase smartcase
set laststatus=2 " Always show the status line
set relativenumber
set number
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set timeoutlen=1000 ttimeoutlen=0
set autoindent
set lazyredraw " Don't redraw screen when running macros
set grepprg=ag " Use silver searcher instead of grep
set shiftround " When at 3 spaces and I hit >> , go to 4, not 5
set nofoldenable " No code folding
set wildmenu " Better completion on command line
set updatetime=100
set colorcolumn=80

if !exists('g:syntax_on')
  syntax enable
endif

" Word wrap in quickfix
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup myfiletypes
  autocmd!

  """ Ruby
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

  """ Misc
  " Refresh buffer contents on cursor wait and term focus
  autocmd CursorHold,CursorHoldI * checktime
  autocmd FocusGained,BufEnter * :checktime

  " Always remove trailing whitespaces
  autocmd BufWritePre * %s/\s\+$//e

  " Always open quickfix window as full-width below
  autocmd FileType qf wincmd J

  " Easy exit help menus with q
  autocmd Filetype help nnoremap <buffer> q :q<CR>

  " Don't automatically continue comments after newline
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup END

augroup mycolors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE
  autocmd ColorScheme * highlight NonText ctermbg=NONE
  autocmd ColorScheme * highlight ColorColumn ctermbg=234
  autocmd ColorScheme * highlight CursorLine ctermbg=234

  " ALE
  autocmd ColorScheme * highlight ALEWarning ctermbg=236
  autocmd ColorScheme * highlight ALEError ctermbg=52
  autocmd ColorScheme * highlight ALEWarningSign ctermbg=NONE
  autocmd ColorScheme * highlight ALEErrorSign ctermbg=NONE

  " Git Gutter
  autocmd ColorScheme * highlight clear SignColumn
  autocmd ColorScheme * highlight GitGutterAdd ctermbg=NONE
  autocmd ColorScheme * highlight GitGutterAdd ctermfg=darkgreen
  autocmd ColorScheme * highlight GitGutterChange ctermbg=NONE
  autocmd ColorScheme * highlight GitGutterChange ctermfg=darkyellow
  autocmd ColorScheme * highlight GitGutterDelete ctermbg=NONE
  autocmd ColorScheme * highlight GitGutterDelete ctermfg=darkred
  autocmd ColorScheme * highlight GitGutterChangeDelete ctermbg=NONE
  autocmd ColorScheme * highlight GitGutterChangeDelete ctermfg=red
augroup END

" search configuration
let g:esearch = {
  \ 'adapter':          'ag',
  \ 'out':              'win',
  \ 'batch_size':       1000,
  \ 'use':              ['visual', 'word_under_cursor', 'last'],
  \ 'default_mappings': 1,
  \}

" other visual stuff
set background=dark
colorscheme hybrid

if has("autocmd")
  " Enable file type detection. Use the default filetype settings, so that
  " mail gets 'tw' set to 72, 'cindent' is on in C files, etc. Also load
  " indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
  augroup END
endif
