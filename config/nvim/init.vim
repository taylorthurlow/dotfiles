call plug#begin('~/.local/share/nvim/plugged')
Plug 'Carpetsmoker/auto_mkdir2.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'
Plug 'markonm/traces.vim'
Plug 'mattn/emmet-vim'
Plug 'plasticboy/vim-markdown'
Plug 'rhysd/committia.vim'
Plug 'romainl/vim-cool'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0ng/vim-hybrid'
Plug 'wellle/targets.vim'
call plug#end()

set breakindent
set colorcolumn=80
set cursorline
set grepprg=ag " Use silver searcher instead of grep
set ignorecase smartcase
set nofoldenable " No code folding
set nowrap
set number
set scrolloff=4 " Keep at least 4 lines around cursor
set shiftround " When at 3 spaces and I hit >> , go to 4, not 5
set smarttab
set splitbelow
set splitright
" set termguicolors

colorscheme hybrid
highlight Normal guibg=NONE ctermbg=NONE

" Set leader key
let mapleader = ","

" Normal bindings
nnoremap <silent> <Ctrl-A> <Nop>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> <C-W>u :call MergeTabs()<CR>

" Window navigation
nnoremap <silent> <C-h> <C-w><C-h>
nnoremap <silent> <C-j> <C-w><C-j>
nnoremap <silent> <C-k> <C-w><C-k>
nnoremap <silent> <C-l> <C-w><C-l>

" Don't put certain actions in the default register, send to black hole
nnoremap x "_x

let loaded_netrwPlugin = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_strikethrough = 1

" Word wrap in quickfix
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

augroup myfiletypes
  autocmd!

  """ Ruby
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal autoindent shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

  """ Markdown
  " autoindent with two spaces, always expand tabs
  autocmd FileType markdown setlocal autoindent shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType markdown setlocal path+=lib

  """ CSS/SCSS
  " autoindent with two spaces, always expand tabs
  autocmd FileType css,scss setlocal autoindent shiftwidth=2 softtabstop=2 expandtab

  """ JSON
  " autoindent with two spaces, always expand tabs
  autocmd FileType json setlocal autoindent shiftwidth=2 softtabstop=2 expandtab

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
