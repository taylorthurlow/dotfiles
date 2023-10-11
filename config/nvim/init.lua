-- Set up leader before plugins (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "Carpetsmoker/auto_mkdir2.vim",                     -- Allow mkdir when editing
  "editorconfig/editorconfig-vim",                    -- Honor .editorconfig if exists
  "tpope/vim-repeat",                                 -- Plugin-friendly '.'-repeats
  "andymass/vim-matchup",                             -- Matching pair highlighting, navigation, and operation
  "airblade/vim-rooter",                              -- Automatically set working directory to project root
  "tpope/vim-sleuth",                                 -- Detect tabstop/shiftwidth automatically
  "romainl/vim-cool",                                 -- Don't highlight search after done searching
  "rhysd/committia.vim",                              -- Better git commit filetype
  "tpope/vim-surround",                               -- It's vim-surround, man
  "tpope/vim-eunuch",                                 -- Easy UNIX commands

  { -- Project-wide search and replace
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { -- Git diff signs in gutter
    "lewis6991/gitsigns.nvim",
    opts = { },
  },
  { -- GitHub copilot
    "zbirenbaum/copilot.lua",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    opts = {},
    -- config = function()
    --   require("copilot_cmp").setup()
    -- end
  },
  { -- Lazygit integration
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
  },
  { -- Easy access to top files in project
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      global_settings = {
        tabline = true,
        mark_branch = false,
      },
    },
  },
  { -- Language server
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Auto-configured lua language server, completion for nvim stuff
      "folke/neodev.nvim",
      -- Auto-format configurable per-server
      "lukas-reineke/lsp-format.nvim",
      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
    },
  },
  { -- Treesitter highlighting & code analysys
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
  { -- Completion
    "hrsh7th/nvim-cmp",
    dependencies = {
       -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      -- Function signature completion
      "ray-x/lsp_signature.nvim",
    },
  },
  { -- Fuzzy finding and general popup finders & pickers
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
  },
  { -- Onedark theme
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "onedark"
    end,
  },
  { -- Simple powerline alternative
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1, -- relative path
            shorting_target = 64, -- at least 64 chars of space for other stuff
          }
        },
      },
    },
  },
  { -- Maybe replacement for tpope/vim-commentary
    "numToStr/Comment.nvim",
    opts = {},
  }
})

-- [[ Vim options ]]

vim.o.mouse = "a"                 -- Enable mouse mode
vim.o.breakindent = true          -- Wrapped lines continue indent
vim.o.undofile = true             -- Save undo history
vim.o.updatetime = 250            -- Much faster idle time to save to swap
vim.o.timeoutlen = 500            -- Faster timeout for key chords
vim.o.termguicolors = true        -- Full-color support
vim.o.hidden = true               -- Don't unload abandoned buffers
vim.o.cursorline = true           -- Highlight
vim.o.autoindent = true           -- Copy indent from current line when starting a new line
vim.o.smartindent = true          -- Smarter indent for some languages
vim.o.smarttab = true             -- Smart alignment when adding tabs
vim.o.scrolloff = 4               -- Keep at least N lines in view around cursor line
vim.o.wrap = false                -- Disable text wrapping
vim.o.showmode = false            -- Disable mode display because lualine already does it

vim.wo.colorcolumn = "80,120"     -- Rulers at 80 and 120 character line lengths
vim.wo.number = true              -- Show line numbers
vim.wo.signcolumn = "yes"         -- Always show sign column

-- Case-insensitive searching unless \C or uppercase in search query
vim.o.ignorecase = true
vim.o.smartcase = true

-- Better vim diff
vim.o.diffopt = vim.o.diffopt .. ",algorithm:patience"
vim.o.diffopt = vim.o.diffopt .. ",indent-heuristic"

-- Sane split directions
vim.o.splitbelow = true
vim.o.splitright = true

-- Completion options
vim.o.completeopt = "menuone,noselect"

-- Format options
--   Wrap text and comments using textwidth
--   continue comments with <CR> in insert mode
--   enable formatting of comments with `gq`
--   detect lists
--   auto-wrap in insert mode, and do not wrap old long lines
vim.o.formatoptions = "tcrqnb"

-- Show weird hidden characters:
--   verbose version: listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
vim.o.listchars = "nbsp:¬,extends:»,precedes:«,trail:•"

-- Use ripgrep in vimgrep mode for :grep command, if it exists
if vim.fn.executable("rg") > 0 then
  vim.o.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
  vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
end

-- [[ Extra visual configuration ]]

-- Highlight yanked text, see `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  }
)

-- [[ nvim-cmp ]]

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "copilot" },
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }),
  sorting = {
    priority_weight = 2,
    comparators = {
      require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

-- [[ Telescope ]]

local telescope = require("telescope")

local telescope_actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<CR>"] = telescope_actions.select_default,
        ["<C-v>"] = telescope_actions.select_vertical,
        ["<C-s>"] = telescope_actions.select_horizontal,
        ["<C-t>"] = telescope_actions.select_tab,
        ["<C-q>"] = telescope_actions.add_selected_to_qflist,
        ["<esc>"] = telescope_actions.close,
      }
    },
    prompt_title = false,
    path_display = { "smart" },
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      flex = {
        flip_columns = 200,
        flip_lines = 40,
      },
      vertical = {
        prompt_position = "top",
        height = 0.95,
      },
      horizontal = {
        prompt_position = "top",
        width = 0.95,
        height = 40,
        preview_width = 0.4,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = telescope_actions.delete_buffer + telescope_actions.move_to_top
        },
      },
    },
    quickfix = {
      layout_strategy = "bottom_pane",
      layout_config = {},
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.99,
        height = 0.99,
      },
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    project = {
      layout_strategy = "bottom_pane",
      layout_config = {},
      base_dirs = {
        { "~/Code", max_depth = 2 },
        { "~/Code/bayphoto", max_depth = 2 },
      },
      order_by = "recent",
      on_project_selected = function(prompt_bufnr)
        require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr, false)
        vim.cmd "silent %bd"
        vim.cmd "echo \"Switched to project\""
      end,
    },
  }
})

telescope.load_extension("fzf")
telescope.load_extension("harpoon")
telescope.load_extension("project")
telescope.load_extension("file_browser")

-- [[ LSP ]]

-- Setup neovim lua configuration
require("neodev").setup()

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- LSP-only keybinds
    nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
    nmap("gr", vim.lsp.buf.rename, "[r]ename symbol")
    nmap("gD", vim.lsp.buf.type_definition, "[g]oto type [D]efinition")
    -- nmap("gD", vim.lsp.buf.declaration, "[g]oto [d]eclaration")
    nmap("<leader>ca", vim.lsp.buf.code_action, "execute [c]ode [a]ction")
    nmap("gh", vim.lsp.buf.hover, "show hover documentation")
    nmap("gH", vim.lsp.buf.signature_help, "show signature documentation")

    -- LSP-only telescope
    local telescope_builtins = require("telescope.builtin")
    nmap("gu", telescope_builtins.lsp_references, "[g]oto [u]ses")
    nmap("gI", telescope_builtins.lsp_implementations, "[g]oto [I]mplementation")
    nmap("<leader>pd", telescope_builtins.diagnostics, "[p]ick a [d]iagnostic to jump to")
    nmap("<leader>ds", telescope_builtins.lsp_document_symbols, "[d]ocument [s]ymbols")
    nmap("<leader>ws", telescope_builtins.lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "Format",
      function(_)
        vim.lsp.buf.format()
      end,
      { desc = "Format current buffer with LSP" }
    )

    -- Get signatures (and _only_ signatures) when in argument lists.
    require("lsp_signature").on_attach({
      doc_lines = 0,
      handler_opts = {
        border = "rounded",
      },
    })

    if client.name == "rust_analyzer"  then
      -- None of this semantics tokens business.
      -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
      client.server_capabilities.semanticTokensProvider = nil

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = true,
          signs = true,
          update_in_insert = true,
        }
      )
    end
  end,
})


local lspconfig = require("lspconfig")
local lsp_format = require("lsp-format")
lsp_format.setup({})

local border = {
  {"╭", "FloatBorder"},
  {"─", "FloatBorder"},
  {"╮", "FloatBorder"},
  {"│", "FloatBorder"},
  {"╯", "FloatBorder"},
  {"─", "FloatBorder"},
  {"╰", "FloatBorder"},
  {"│", "FloatBorder"},
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Set default LSP config
lspconfig.util.default_config = vim.tbl_deep_extend(
  "force",
  lspconfig.util.default_config,
  {
    -- nvim-cmp supports additional completion capabilities
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  }
)

lspconfig.rust_analyzer.setup({
  -- TODO: Figure out how to get locally defined methods to actually work for on_attach
  on_attach = lsp_format.on_attach,
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
})

lspconfig.tsserver.setup({
  on_attach = lsp_format.on_attach,
})

lspconfig.standardrb.setup({
  cmd = { "bundle", "exec", "standardrb", "--lsp" },
  on_attach = lsp_format.on_attach,
  filetypes = { "ruby" },
})

lspconfig.solargraph.setup({
  cmd = { "bundle", "exec", "solargraph", "stdio" },
  init_options = { formatting = false },
  filetypes = { "ruby" },
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
})

-- [[ Treesitter ]]

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "rust", "ruby", "typescript", "javascript", "vim" },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  matchup = { enable = true },
  incremental_selection = { enable = true },
  textobjects = {
    enable = true,
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
})

-- [[ Keyboard Bindings ]]

-- Delete character under cursor and send it to the black hole register instead
-- of the primary register
vim.keymap.set("n", "x", "\"_x")

-- Stop highlighting things
vim.keymap.set("n", "<leader>hh", ":nohl<CR>")

-- Reload config
vim.keymap.set("n", "<leader>vr", ":source ~/.config/nvim/init.lua<CR>")

-- Show git blame for current line
vim.keymap.set("n", "gb", require("gitsigns").blame_line, { desc = "[g]it [b]lame current line" })

local telescope_builtins = require("telescope.builtin")

-- Telescope "find" shortcuts (find something that might exist)
vim.keymap.set("n", "<leader>ff", telescope_builtins.find_files,                { desc = "[f]ind [f]iles in project" })
vim.keymap.set("n", "<leader>fs", telescope_builtins.live_grep,                 { desc = "[f]ind sub[s]tring in project" })
vim.keymap.set("n", "<leader>ft", telescope_builtins.grep_string,               { desc = "[f]ind [t]hing under cursor (or selection) in project" })
vim.keymap.set("n", "<leader>fq", telescope_builtins.quickfixhistory,           { desc = "[f]ind old [q]uickfix list" })
vim.keymap.set("n", "<leader>fc", telescope_builtins.commands,                  { desc = "[f]ind and execute [c]ommand" })
vim.keymap.set("n", "<leader>fi", telescope_builtins.current_buffer_fuzzy_find, { desc = "[f]ind [i]nside current buffer" })
vim.keymap.set("n", "<leader>fh", telescope_builtins.help_tags,                 { desc = "[f]ind [h]elp document tag" })

-- Telescope "pick" shortcuts (find something that I expect to exist)
vim.keymap.set("n", "<leader>pb", telescope_builtins.buffers,                   { desc = "[p]ick a [b]uffer to switch to" })
vim.keymap.set("n", "<leader>pm", telescope_builtins.marks,                     { desc = "[p]ick a [m]ark to jump to" })
vim.keymap.set("n", "<leader>pq", telescope_builtins.quickfix,                  { desc = "[p]ick a [q]uickfix entry to jump to" })
vim.keymap.set("n", "<leader>pr", telescope_builtins.registers,                 { desc = "[p]ick a [r]egister to paste" })
vim.keymap.set("n", "<leader>pc", telescope_builtins.command_history,           { desc = "[p]ick a previously run [c]ommand to execute" })
vim.keymap.set("n", "<leader>ps", telescope_builtins.search_history,            { desc = "[p]ick a previous [s]earch to execute" })
vim.keymap.set("n", "<leader>ph", telescope.extensions.harpoon.marks,           { desc = "[p]ick a [h]arpoon mark to jump to" })

-- Other stuff
vim.keymap.set("n", "<leader>op", telescope.extensions.project.project,           { desc = "[o]pen a [p]roject" })
vim.keymap.set("n", "<leader>oe", telescope.extensions.file_browser.file_browser, { desc = "[o]pen file [e]xplorer" })
vim.keymap.set("n", "<leader>og", function() vim.cmd("LazyGit") end,              { desc = "[o]pen lazy[g]it" })
vim.keymap.set("n", "<leader>fr", "<cmd>lua require(\"spectre\").toggle()<CR>",   { desc = "[f]ind and [r]eplace in project" })

-- Remove trailing whitespace without messing with cursor position
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Harpoon
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>mf", harpoon_mark.add_file,                             { desc = "[m]ark a [f]ile with harpoon" })
vim.keymap.set("n", "<leader>ml", harpoon_ui.toggle_quick_menu,                      { desc = "open harpoon [m]arks [l]ist" })
vim.keymap.set("n", "<leader>mn", harpoon_ui.nav_next,                               { desc = "jump to [n]ext harpoon [m]ark" })
vim.keymap.set("n", "<leader>mp", harpoon_ui.nav_prev,                               { desc = "jump to [p]rev harpoon [m]ark" })
vim.keymap.set("n", "<leader>1",  function() require("harpoon.ui").nav_file(1) end,  { desc = "jump to harpoon mark [1]" })
vim.keymap.set("n", "<leader>2",  function() require("harpoon.ui").nav_file(2) end,  { desc = "jump to harpoon mark [2]" })
vim.keymap.set("n", "<leader>3",  function() require("harpoon.ui").nav_file(3) end,  { desc = "jump to harpoon mark [3]" })
vim.keymap.set("n", "<leader>4",  function() require("harpoon.ui").nav_file(4) end,  { desc = "jump to harpoon mark [4]" })

-- vim: ts=2 sts=2 sw=2 et

