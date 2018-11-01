" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
call vundle#end()

" Set leader key
let mapleader = ","

" Normal bindings
nnoremap 0 ^  
nnoremap j gj
nnoremap k gk
" inoremap <silent><expr><BS> 
"   \ (&indentexpr isnot '' ? &indentkeys : &cinkeys) =~? '!\^F' &&
"   \ &backspace =~? '.*eol\&.*start\&.*indent\&' &&
"   \ !search('\S','nbW',line('.')) ? (col('.') != 1 ? "\<C-U>" : "") .
"   \ "\<BS>" . (getline(line('.')-1) =~ '\S' ? "" : "\<C-F>") : "\<BS>"
" inoremap <C-BS> <BS>

" Leader bindings
nnoremap <leader>vr :tabe $MYVIMRC<CR>
nnoremap <leader>so :source $MYVIMRC <CR>
noremap <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

" Ctrl+s to save, also exits insert mode
noremap <C-s> <esc>:w<CR>
inoremap <C-s> <esc>:w<CR>

" Options
set nocompatible " Don't maintain compatibility with Vi
set hidden " Allow buffer change without saving
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
set showmatch 
set nowrap
set smarttab
set ignorecase smartcase
set laststatus=2 " Always show the status line
set relativenumber
set number
highlight LineNr ctermfg=Grey
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set timeoutlen=1000 ttimeoutlen=0
set autoindent
set lazyredraw " Don't redraw screen when running macros
set grepprg=ag " Use silver searcher instead of grep
set shiftround " When at 3 spaces and I hit >> , go to 4, not 5
set nofoldenable " No code folding
set wildmenu " Better completion on command line

" Merge a tab into a split in the previous window
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

nmap <C-W>u :call MergeTabs()<CR>

" Squash all commits into the first during rebase
function! SquashAll()
  normal ggj}klllcf
endfunction

function! SearchForCallSitesCursor()
  let searchterm = expand("<cword>")
    call searchforcallsites(searchterm)
  endfunction

" search for call sites for term (excluding its definition) and
" load into the quickfix list.
function! SearchForCallSites(term)
  cexpr system('ag ' . shellescape(a:term) . '\| grep -v def')
endfunction

" make ctrlp use ag for listing the files. way faster and no useless
" files.
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 1

autocmd Filetype help nnoremap <buffer> q :q<CR>

" Don't automatically continue comments after newline
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
" ==========================
" Ruby Stuff
" ==========================
syntax on

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=80
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
augroup END

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent
  " indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them
  " easily.
  augroup vimrcEx
    au!

    " When editing a file, always jump to the last known
    " cursor position.
    " Don't do it when the position is invalid or
    " when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

  augroup END

endif " has("autocmd")
