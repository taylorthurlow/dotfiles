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
Plugin 'dhruvasagar/vim-zoom'
Plugin 'flazz/vim-colorschemes'
Plugin 'gmarik/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'machakann/vim-highlightedyank'
Plugin 'mattn/emmet-vim'
Plugin 'maximbaz/lightline-ale'
Plugin 'rhysd/committia.vim'
Plugin 'romainl/vim-cool'
Plugin 'rust-lang/rust.vim'
Plugin 'sbdchd/neoformat'
Plugin 'shime/vim-livedown'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-ruby/vim-ruby'
Plugin 'w0rp/ale'
Plugin 'yegappan/greplace'
call vundle#end()
filetype plugin indent on " required by Vundle

" Set cursor types in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

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
nnoremap <leader>fo :w<CR>:Neoformat<CR>
nnoremap <leader>pp :setlocal paste!<CR>
nnoremap <silent> <leader>pa :setlocal paste<CR>"+p :setlocal nopaste<CR>

" tags
nnoremap <C-]> :exec("tag ".expand("<cword>"))<CR>
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <C-[> :split <CR>:exec("tag ".expand("<cword>"))<CR>
nunmap <Esc>

" custom text objects
" "in indentation" (indentation level sans any surrounding empty lines)
xnoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>
onoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>'
" "around indentation" (indentation level and any surrounding empty lines)
xnoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
onoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
" "in number" (next number after cursor on current line)
xnoremap <silent> in :<c-u>call <sid>inNumber()<cr>
onoremap <silent> in :<c-u>call <sid>inNumber()<cr>
" "around number" (next number on line and possible surrounding white-space)
xnoremap <silent> an :<c-u>call <sid>aroundNumber()<cr>
onoremap <silent> an :<c-u>call <sid>aroundNumber()<cr>

let g:vimrubocop_keymap = 0
let g:rspec_command = '!bundle exec rspec {spec}'
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 500
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

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

  """ Ruby """
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

  """ Misc """
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

" lightline configuration
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'inactive': {
      \   'left': [ [ 'mode', 'paste', 'zoomstatus' ], [ 'ctrlpmark' ],
      \             [ 'gitbranch', 'readonly', 'lightline_filename', 'modified' ] ],
      \   'right': [[ 'filetype' ]],
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'zoomstatus' ], [ 'ctrlpmark' ],
      \             [ 'gitbranch', 'readonly', 'lightline_filename', 'modified' ] ],
      \   'right': [ ['linter_checking', 'linter_errors', 'linter_warnings',
      \                'linter_ok' ],
      \             [ 'filetype' ]],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'lightline_filename': 'LightlineFilename',
      \   'zoomstatus': 'zoom#statusline'
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

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

" other visual stuff
colorscheme Tomorrow-Night-Bright

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

function! s:inIndentation()
  " select all text in current indentation level excluding any empty lines
  " that precede or follow the current indentationt level;
  "
  " the current implementation is pretty fast, even for many lines since it
  " uses "search()" with "\%v" to find the unindented levels
  "
  " NOTE: if the current level of indentation is 1 (ie in virtual column 1),
  "       then the entire buffer will be selected
  "
  " WARNING: python devs have been known to become addicted to this

  " magic is needed for this
  let l:magic = &magic
  set magic

  " move to beginning of line and get virtcol (current indentation level)
  " BRAM: there is no searchpairvirtpos() ;)
  normal! ^
  let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

  " pattern matching anything except empty lines and lines with recorded
  " indentation level
  let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

  " find first match (backwards & don't wrap or move cursor)
  let l:start = search(l:pat, 'bWn') + 1

  " next, find first match (forwards & don't wrap or move cursor)
  let l:end = search(l:pat, 'Wn')

  if (l:end !=# 0)
    " if search succeeded, it went too far, so subtract 1
    let l:end -= 1
  endif

  " go to start (this includes empty lines) and--importantly--column 0
  execute 'normal! '.l:start.'G0'

  " skip empty lines (unless already on one .. need to be in column 0)
  call search('^[^\n\r]', 'Wc')

  " go to end (this includes empty lines)
  execute 'normal! Vo'.l:end.'G'

  " skip backwards to last selected non-empty line
  call search('^[^\n\r]', 'bWc')

  " go to end-of-line 'cause why not
  normal! $o

  " restore magic
  let &magic = l:magic
endfunction

function! s:aroundIndentation()
  " select all text in the current indentation level including any emtpy
  " lines that precede or follow the current indentation level;
  "
  " the current implementation is pretty fast, even for many lines since it
  " uses "search()" with "\%v" to find the unindented levels
  "
  " NOTE: if the current level of indentation is 1 (ie in virtual column 1),
  "       then the entire buffer will be selected
  "
  " WARNING: python devs have been known to become addicted to this

  " magic is needed for this (/\v doesn't seem work)
  let l:magic = &magic
  set magic

  " move to beginning of line and get virtcol (current indentation level)
  " BRAM: there is no searchpairvirtpos() ;)
  normal! ^
  let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

  " pattern matching anything except empty lines and lines with recorded
  " indentation level
  let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

  " find first match (backwards & don't wrap or move cursor)
  let l:start = search(l:pat, 'bWn') + 1

  " NOTE: if l:start is 0, then search() failed; otherwise search() succeeded
  "       and l:start does not equal line('.')
  " FORMER: l:start is 0; so, if we add 1 to l:start, then it will match
  "         everything from beginning of the buffer (if you don't like
  "         this, then you can modify the code) since this will be the
  "         equivalent of "norm! 1G" below
  " LATTER: l:start is not 0 but is also not equal to line('.'); therefore,
  "         we want to add one to l:start since it will always match one
  "         line too high if search() succeeds

  " next, find first match (forwards & don't wrap or move cursor)
  let l:end = search(l:pat, 'Wn')

  " NOTE: if l:end is 0, then search() failed; otherwise, if l:end is not
  "       equal to line('.'), then the search succeeded.
  " FORMER: l:end is 0; we want this to match until the end-of-buffer if it
  "         fails to find a match for same reason as mentioned above;
  "         again, modify code if you do not like this); therefore, keep
  "         0--see "NOTE:" below inside the if block comment
  " LATTER: l:end is not 0, so the search() must have succeeded, which means
  "         that l:end will match a different line than line('.')

  if (l:end !=# 0)
    " if l:end is 0, then the search() failed; if we subtract 1, then it
    " will effectively do "norm! -1G" which is definitely not what is
    " desired for probably every circumstance; therefore, only subtract one
    " if the search() succeeded since this means that it will match at least
    " one line too far down
    " NOTE: exec "norm! 0G" still goes to end-of-buffer just like "norm! G",
    "       so it's ok if l:end is kept as 0. As mentioned above, this means
    "       that it will match until end of buffer, but that is what I want
    "       anyway (change code if you don't want)
    let l:end -= 1
  endif

  " finally, select from l:start to l:end
  execute 'normal! '.l:start.'G0V'.l:end.'G$o'

  " restore magic
  let &magic = l:magic
endfunction

function! s:aroundNumber()
	" select the next number on the line and any surrounding white-space;
	" this can handle the following three formats (so long as s:regNums is
	" defined as it should be above these functions):
	"   1. binary  (eg: "0b1010", "0b0000", etc)
	"   2. hex     (eg: "0xffff", "0x0000", "0x10af", etc)
	"   3. decimal (eg: "0", "0000", "10", "01", etc)
	" NOTE: if there is no number on the rest of the line starting at the
	"       current cursor position, then visual selection mode is ended (if
	"       called via an omap) or nothing is selected (if called via xmap);
	"       this is true even if on the space following a number

	" need magic for this to work properly
	let l:magic = &magic
	set magic

	let l:lineNr = line('.')

	" create regex pattern matching any binary, hex, decimal number
	let l:pat = join(s:regNums, '\+\|') . '\+'

	" move cursor to end of number
	if (!search(l:pat, 'ce', l:lineNr))
		" if it fails, there was not match on the line, so return prematurely
		return
	endif

	" move cursor to end of any trailing white-space (if there is any)
	call search('\%'.(virtcol('.')+1).'v\s*', 'ce', l:lineNr)

	" start visually selecting from end of number + potential trailing whitspace
	normal! v

	" move cursor to beginning of number
	call search(l:pat, 'cb', l:lineNr)

	" move cursor to beginning of any white-space preceding number (if any)
	call search('\s*\%'.virtcol('.').'v', 'b', l:lineNr)

	" restore magic
	let &magic = l:magic
endfunction

" regular expressions that match numbers (order matters .. keep '\d' last!)
" note: \+ will be appended to the end of each
let s:regNums = [ '0b[01]', '0x\x', '\d' ]

function! s:inNumber()
	" select the next number on the line
	" this can handle the following three formats (so long as s:regNums is
	" defined as it should be above this function):
	"   1. binary  (eg: "0b1010", "0b0000", etc)
	"   2. hex     (eg: "0xffff", "0x0000", "0x10af", etc)
	"   3. decimal (eg: "0", "0000", "10", "01", etc)
	" NOTE: if there is no number on the rest of the line starting at the
	"       current cursor position, then visual selection mode is ended (if
	"       called via an omap) or nothing is selected (if called via xmap)

	" need magic for this to work properly
	let l:magic = &magic
	set magic

	let l:lineNr = line('.')

	" create regex pattern matching any binary, hex, decimal number
	let l:pat = join(s:regNums, '\+\|') . '\+'

	" move cursor to end of number
	if (!search(l:pat, 'ce', l:lineNr))
		" if it fails, there was not match on the line, so return prematurely
		return
	endif

	" start visually selecting from end of number
	normal! v

	" move cursor to beginning of number
	call search(l:pat, 'cb', l:lineNr)

	" restore magic
	let &magic = l:magic
endfunction

