call plug#begin('~/.local/share/nvim/plugged')
" Allow mkdir when editing
Plug 'Carpetsmoker/auto_mkdir2.vim'

" Honor .editorconfig if exists
Plug 'editorconfig/editorconfig-vim'

" Onedark theme
Plug 'navarasu/onedark.nvim'

" Maybe replacement for tpope/vim-commentary
Plug 'numToStr/Comment.nvim'

" Maybe replacement for tpope/vim-surround
Plug 'machakann/vim-sandwich'

" Neovim treesitter highlighting and more
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Sweet commits
Plug 'rhysd/committia.vim'

" Tpope goodness
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'

" Light powerline
Plug 'itchyny/lightline.vim'

" Highlight matching pairs and more
Plug 'andymass/vim-matchup'

" Auto-set working directory to project root
Plug 'airblade/vim-rooter'

" Fuzzy finder/picker
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'ThePrimeagen/harpoon'

" Lazy git!!
Plug 'kdheepak/lazygit.nvim'

" File explorer
Plug 'nvim-tree/nvim-tree.lua'

" LSP, hinting, completion, etc
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'} " only because nvim-cmp requires it
Plug 'hrsh7th/vim-vsnip'                     " only because nvim-cmp requires it
call plug#end()

set hidden
set breakindent
set noshowmode
set autoindent shiftwidth=2 softtabstop=2 expandtab
set colorcolumn=80,120
set cursorline
set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m
set ignorecase smartcase
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set nowrap
set number
set scrolloff=4 " Keep at least 4 lines around cursor
set smarttab
set splitbelow
set splitright
set termguicolors
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments with ENTER in insert mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines
set signcolumn=yes
set wildmenu
set wildmode=list:longest
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•


"
" THEME AND VISUALS
"

" Color scheme
colorscheme onedark

" Lightline
let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'background': 'dark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileencoding', 'filetype' ] ],
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename'
  \ },
  \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

au TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}

"
" KEYBOARD BINDINGS
"

" Set leader key
nnoremap <space> <Nop>
let mapleader = " "

nnoremap <silent> <leader>vr :source /Users/taylor/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>og :LazyGit<CR>

nnoremap <silent> <Ctrl-A> <Nop>
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <C-h> :nohlsearch<CR>
nnoremap <C-h> :nohlsearch<CR>

" Centered search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Send single-character deletion to black hole instead of standard register
nnoremap x "_x

" Telescope "find" shortcuts (find something that may or may not exist)
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fs <cmd>Telescope live_grep<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>ft <cmd>Telescope grep_string<CR>
nnoremap <leader>fq <cmd>Telescope quickfixhistory<CR>
nnoremap <leader>fc <cmd>Telescope commands<CR>
nnoremap <leader>fi <cmd>Telescope current_buffer_fuzzy_find<CR>

" Telescope "pick" shortcuts (pick something that I expect to exist)
nnoremap <leader>pb <cmd>Telescope buffers<CR>
nnoremap <leader>pm <cmd>Telescope marks<CR>
nnoremap <leader>pq <cmd>Telescope quickfix<CR>
nnoremap <leader>pr <cmd>Telescope registers<CR>
nnoremap <leader>pc <cmd>Telescope command_history<CR>
nnoremap <leader>ps <cmd>Telescope search_history<CR>

" Telescope LSP shortcuts
nnoremap <leader>op <cmd>Telescope project<CR>
nnoremap <leader>oe <cmd>Telescope file_browser<CR>
nnoremap <leader>od <cmd>Telescope diagnostics<CR>
nnoremap <leader>gd <cmd>Telescope lsp_definitions<CR>
nnoremap <leader>gi <cmd>Telescope lsp_implementations<CR>
nnoremap <leader>gr <cmd>Telescope lsp_references<CR>
nnoremap <leader>gt <cmd>Telescope lsp_type_definitions<CR>

"
" FILETYPE SPECIFIC
"

augroup myfiletypes
  au!

  """ Ruby
  " autoindent with two spaces, always expand tabs
  au FileType ruby,eruby,yaml setlocal autoindent shiftwidth=2 softtabstop=2 expandtab
  au FileType ruby,eruby,yaml setlocal path+=lib
  " Make ?s part of words
  au FileType ruby,eruby,yaml setlocal iskeyword+=?

  """ Rust
  " autoindent with two spaces, always expand tabs
  au FileType rust setlocal autoindent shiftwidth=4 softtabstop=4 expandtab
  au Filetype rust setlocal colorcolumn=100

  """ Markdown
  " autoindent with two spaces, always expand tabs
  au FileType markdown setlocal autoindent shiftwidth=2 softtabstop=2 expandtab
  au FileType markdown setlocal path+=lib

  """ CSS/SCSS
  " autoindent with two spaces, always expand tabs
  au FileType css,scss setlocal autoindent shiftwidth=2 softtabstop=2 expandtab

  """ JSON
  " autoindent with two spaces, always expand tabs
  au FileType json setlocal autoindent shiftwidth=2 softtabstop=2 expandtab

  """ Misc
  " Refresh buffer contents on cursor wait and term focus
  au CursorHold,CursorHoldI * checktime
  au FocusGained,BufEnter * :checktime

  " Always remove trailing whitespaces
  au BufWritePre * %s/\s\+$//e

  " Always open quickfix window as full-width below
  au FileType qf wincmd J

  " Easy exit help menus with q
  au Filetype help nnoremap <buffer> q :q<CR>

  " Don't automatically continue comments after newline
  au BufNewFile,BufRead * setlocal formatoptions-=cro
augroup END

let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

"
" MISCELLANEOUS
"

" Disable netrw by telling it a bunch of stuff is already loaded
let loaded_netrw = 1
let loaded_netrwPlugin = 1
let loaded_netrwSettings = 1
let loaded_netrwFileHandler = 1
let loaded_netrw_gitignore = 1

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

" Comment.vim

lua << EOF
  require('Comment').setup()
EOF

" Treesitter

lua << EOF
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true
    },
    incremental_selection = {
      enable = true,
    },
    textobjects = {
      enable = true
    },
    indent = {
      enable = true
    },
    matchup = {
      enable = true
    },
  }
EOF

" Telescope

lua << EOF
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  -- Extensions
  local project_actions = require("telescope._extensions.project.actions")

  -- Full setup
  telescope.setup{
    defaults = {
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<CR>"] = actions.select_default,
          ["<C-v>"] = actions.select_vertical,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-t>"] = actions.select_tab,
          ["<C-q>"] = actions.add_selected_to_qflist,
          -- ["<esc>"] = actions.close,
        }
      },
      layout_strategy = "flex",
      layout_config = {
        flip_columns = 200,
        flip_lines = 40,
      }
    },
    pickers = {
      buffers = {
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer + actions.move_to_top
          }
        }
      },
      quickfix = {
        layout_strategy = "bottom_pane",
        layout_config = {},
      },
      project = {
        layout_strategy = "bottom_pane",
        layout_config = {},
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      },
      project = {
        base_dirs = {
          { "~/Code", max_depth = 2 },
          { "~/Code/bayphoto", max_depth = 2 },
        },
        order_by = "recent",
        on_project_selected = function(prompt_bufnr)
          project_actions.change_working_directory(prompt_bufnr, false)
          vim.cmd "silent %bd"
          vim.cmd 'echo "Switched to project"'
        end
      },
      file_browser = {

      },
    }
  }

  telescope.load_extension("project")
  telescope.load_extension("file_browser")
EOF

" nvim-cmp

lua << EOF
   -- Set up nvim-cmp.
  local cmp = require'cmp'
  local lspconfig = require'lspconfig'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    view = {
      entries = "custom"
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      -- TODO: snippets from LSP end up getting prioritized, lame
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

    -- None of this semantics tokens business.
    -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
    client.server_capabilities.semanticTokensProvider = nil

    -- Get signatures (and _only_ signatures) when in argument lists.
    require "lsp_signature".on_attach({
      doc_lines = 0,
      handler_opts = {
        border = "none"
      },
    })
  end

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    onattach = onattach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        completion = {
          postfix = {
            enable = false,
          },
        },
      },
    },
  }
EOF

