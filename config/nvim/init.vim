call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Carpetsmoker/auto_mkdir2.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dhruvasagar/vim-zoom'
Plug 'editorconfig/editorconfig-vim'
Plug 'eugen0329/vim-esearch'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'knubie/vim-kitty-navigator'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
Plug 'markonm/traces.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/clever-f.vim'
Plug 'rhysd/committia.vim'
Plug 'romainl/vim-cool'
Plug 'RRethy/vim-hexokinase'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sillyotter/t4-vim'
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

" Set leader key
let mapleader = ","

" Normal bindings
nnoremap <Ctrl-A> <Nop>
nnoremap j gj
nnoremap k gk
nnoremap <C-W>u :call MergeTabs()<CR>

" Don't put certain actions in the default register, send to black hole
nnoremap x "_x

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
nnoremap <leader>tf :call RunCurrentSpecFile()<CR>
nnoremap <leader>ts :call RunNearestSpec()<CR>
nnoremap <leader>tl :call RunLastSpec()<CR>
nnoremap <leader>ta :call RunAllSpecs()<CR>
nnoremap <leader>fo :w<CR>:Neoformat<CR>
nnoremap <leader>pp :setlocal paste!<CR>
nnoremap <silent> <leader>pa :setlocal paste<CR>"+p :setlocal nopaste<CR>

" tags
nnoremap <C-]> :exec("tag ".expand("<cword>"))<CR>
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <C-[> :split <CR>:exec("tag ".expand("<cword>"))<CR>
nunmap <Esc>

let g:deoplete#enable_at_startup = 1
let g:rspec_command = '!bundle exec rspec {spec}'
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 1000
let loaded_netrwPlugin = 1
let g:indentLine_faster = 1
let g:indentLine_setConceal = 0
let g:gutentags_file_list_command = {
      \ 'markers': {
      \ '.git': 'git ls-files',
      \ },
      \ }
let g:Hexokinase_ftAutoload = ['css', 'scss', 'conf', 'config']

" ctrlP
let g:ctrlp_use_caching = 0
" let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others --exclude-standard']
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
endif

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

augroup mycolors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=None
  autocmd ColorScheme * highlight NonText ctermbg=None
  autocmd ColorScheme * highlight Normal guibg=None
  autocmd ColorScheme * highlight NonText guibg=None
  autocmd ColorScheme * highlight ColorColumn ctermbg=234
  autocmd ColorScheme * highlight CursorLine ctermbg=234

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

colorscheme hybrid

" search configuration
let g:esearch = {
  \ 'adapter':          'ag',
  \ 'out':              'win',
  \ 'batch_size':       1000,
  \ 'use':              ['visual', 'word_under_cursor', 'last'],
  \ 'default_mappings': 1,
  \}

" lightline configuration
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'inactive': {
      \   'left': [ [ 'mode', 'paste' ], [ 'ctrlpmark' ],
      \             [ 'gitbranch', 'readonly', 'lightline_filename', 'modified' ] ],
      \   'right': [[ 'filetype' ]],
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'zoomstatus' ], [ 'ctrlpmark' ],
      \             [ 'gitbranch', 'readonly', 'lightline_filename', 'modified' ] ],
      \   'right': [[ 'filetype' ]],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'lightline_filename': 'LightlineFilename'
      \ },
      \ }

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:lightline.component = {
  \ 'filename': '%{expand("%:t") == "ControlP" ? g:lightline.ctrlp_item : expand("%:p")}'
  \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

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
