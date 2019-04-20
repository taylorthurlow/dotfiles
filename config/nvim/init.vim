call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Carpetsmoker/auto_mkdir2.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'eugen0329/vim-esearch'
Plug 'jiangmiao/auto-pairs'
Plug 'knubie/vim-kitty-navigator'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
Plug 'markonm/traces.vim'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/clever-f.vim'
Plug 'rhysd/committia.vim'
Plug 'romainl/vim-cool'
Plug 'ruby-formatter/rufo-vim'
Plug 'sheerun/vim-polyglot'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'w0ng/vim-hybrid'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'yegappan/greplace'
Plug 'Yggdroot/indentLine'
Plug 'zivyangll/git-blame.vim'
call plug#end()

set background=dark
set breakindent
set colorcolumn=80
set cursorline
set grepprg=ag " Use silver searcher instead of grep
set ignorecase smartcase
set nofoldenable " No code folding
set nowrap
set number
set relativenumber
set scrolloff=4 " Keep at least 4 lines around cursor
set shiftround " When at 3 spaces and I hit >> , go to 4, not 5
set smarttab
set splitbelow
set splitright
set termguicolors

if exists("g:gui_oni")
	" Disable status bar
	set laststatus=0 ruler
	set noruler
	set noshowcmd
endif

colorscheme hybrid

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

" Shift lines up and down
nnoremap <silent> <C-S-j> :m .+1<CR>==
nnoremap <silent> <C-S-k> :m .-2<CR>==
inoremap <silent> <C-S-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <C-S-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <C-S-j> :m '>+1<CR>gv=gv
vnoremap <silent> <C-S-k> :m '<-2<CR>gv=gv

" leader bindings
nnoremap <leader>vr :tabe $MYVIMRC<CR>
nnoremap <leader>so :source $MYVIMRC<CR>
nnoremap <leader>tf :call RunCurrentSpecFile()<CR>
nnoremap <leader>ts :call RunNearestSpec()<CR>
nnoremap <leader>tl :call RunLastSpec()<CR>
nnoremap <leader>ta :call RunAllSpecs()<CR>
nnoremap <leader>fo :Rufo<CR>
nnoremap <leader>pp :setlocal paste!<CR>
nnoremap <silent> <leader>pa :setlocal paste<CR>"+p :setlocal nopaste<CR>

" tags
nnoremap <C-]> :exec("tag ".expand("<cword>"))<CR>
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <C-[> :split <CR>:exec("tag ".expand("<cword>"))<CR>
nunmap <Esc>

let g:rufo_auto_formatting = 1
let g:rspec_command = '!bundle exec rspec {spec}'
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 250
let loaded_netrwPlugin = 1
let g:indentLine_faster = 1
let g:indentLine_setConceal = 0
let g:gutentags_file_list_command = {
	\ 'markers': {
	\ '.git': 'git ls-files',
	\ },
	\ }

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

" search configuration
let g:esearch = {
  \ 'adapter':          'ag',
  \ 'backend':          'nvim',
  \ 'out':              'win',
  \ 'batch_size':       1000,
  \ 'use':              ['visual', 'last'],
  \ 'default_mappings': 1,
  \}

augroup mycolors
	" ALE
	autocmd ColorScheme * highlight ALEWarning ctermbg=236
	autocmd ColorScheme * highlight ALEError ctermbg=52
	autocmd ColorScheme * highlight ALEWarningSign ctermbg=None
	autocmd ColorScheme * highlight ALEErrorSign ctermbg=None

	" Git Gutter
	autocmd ColorScheme * highlight clear SignColumn
	autocmd ColorScheme * highlight GitGutterAdd ctermbg=None
	autocmd ColorScheme * highlight GitGutterAdd ctermfg=darkgreen
	autocmd ColorScheme * highlight GitGutterChange ctermbg=None
	autocmd ColorScheme * highlight GitGutterChange ctermfg=darkyellow
	autocmd ColorScheme * highlight GitGutterDelete ctermbg=None
	autocmd ColorScheme * highlight GitGutterDelete ctermfg=darkred
	autocmd ColorScheme * highlight GitGutterChangeDelete ctermbg=None
	autocmd ColorScheme * highlight GitGutterChangeDelete ctermfg=red
augroup END

if has("autocmd")
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
