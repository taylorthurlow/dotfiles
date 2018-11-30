runtime! plugin/sensible.vim

" Vundle
set nocompatible " required by Vundle
filetype off     " required by Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'airblade/vim-gitgutter'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'Carpetsmoker/auto_mkdir2.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dansomething/vim-eclim'
" Plugin 'edkolev/tmuxline.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'gmarik/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mattn/emmet-vim'
Plugin 'ngmy/vim-rubocop'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'w0rp/ale'
Plugin 'yegappan/greplace'
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
nnoremap <Ctrl-A> <Nop>
nnoremap j gj
nnoremap k gk
noremap <C-s> <esc>:w<CR>
inoremap <C-s> <esc>:w<CR>
nnoremap <C-W>u :call MergeTabs()<CR>

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
noremap <leader>tf :call RunCurrentSpecFile()<CR>
noremap <leader>ts :call RunNearestSpec()<CR>
noremap <leader>tl :call RunLastSpec()<CR>
noremap <leader>ta :call RunAllSpecs()<CR>
nnoremap <leader>rc :w<CR>:RuboCop<CR>
nnoremap <leader>rf :w<CR>:RuboCop -x<CR>
nnoremap <leader>ra :w<CR>:RuboCop -a<CR>
nnoremap <leader>fu :call SearchForCallSitesCursor()<CR>

let g:vimrubocop_keymap = 0
let g:rspec_command = '!bundle exec rspec {spec}'
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 1000
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
let g:ycm_max_num_candidates = 5
let g:ycm_max_num_identifier_candidates = 5

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
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
  " Refresh buffer contents on cursor wait and term focus
  autocmd CursorHold,CursorHoldI * checktime
  autocmd FocusGained,BufEnter * :checktime
  " Always remove trailing whitespaces
  autocmd BufWritePre * %s/\s\+$//e

  " Always open quickfix window as full-width below
  autocmd FileType qf wincmd J

  autocmd Filetype help nnoremap <buffer> q :q<CR>

  " Don't automatically continue comments after newline
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup END

augroup mycolors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE
  autocmd ColorScheme * highlight NonText ctermbg=NONE
  autocmd ColorScheme * highlight ColorColumn ctermbg=234
  autocmd ColorScheme * highlight ALEWarning ctermbg=60
  autocmd ColorScheme * highlight ALEError ctermbg=52
  autocmd ColorScheme * highlight clear SignColumn
  autocmd ColorScheme * highlight CursorLine ctermbg=234
augroup END

let g:tmuxline_separators = { 'left': '', 'right': '',
                            \ 'left_alt': ':', 'right_alt': '|' }
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_skip_empty_sections = 1
let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
let g:airline_section_x = '%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#wrap(airline#parts#filetype(),0)}'
let g:airline_section_y = ''
let g:airline_section_z = '%1v'
colorscheme Tomorrow-Night

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

"
" Function Definitions
"

function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  split
  execute "buffer " . bufferName
endfunction

" Squash all commits into the first during rebase
function! SquashAll()
  normal ggj}klllcf
endfunction

function! SearchForCallSitesCursor()
  let searchterm = expand("<cword>")
  call SearchForCallSites(searchterm)
endfunction

" search for call sites for term (excluding its definition) and
" load into the quickfix list.
function! SearchForCallSites(term)
  cexpr system('ag ' . shellescape(a:term) . '\| grep -v def')
endfunction
