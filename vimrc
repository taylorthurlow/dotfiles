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

" =Options
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


" Auto Commands
autocmd Filetype help nnoremap <buffer> q :q<CR>

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
