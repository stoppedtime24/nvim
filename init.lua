-- Change Leader key
vim.g.mapleader = " "
vim.g.maplocaleader = " " 
vim.keymap.set('n', '<Space>', '<Space>', {noremap = true})

-- Force GUI colours
vim.opt.termguicolors = true

-- Uses Nerd Font installed and selected in Terminal settings
vim.g.have_nerd_font = true

-- Use both relative and normal line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = 'a'

-- Shows current mode 
vim.opt.showmode = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-sensitive searching unless \C or one or more capital letters in search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview subsitutions live
vim.opt.inccommand = 'split'

--Show line cursor is on
vim.opt.cursorline = true

-- Minimal number of lines to keep above and below cursor
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Adding keymap to ShowkeysToggle
vim.keymap.set('n', '<leader>skt', '<cmd>ShowkeysToggle<CR>')

-- lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  checker = { enabled = false },
  {
    'tpope/vim-sleuth',        
  },

  -- For the theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority  = 1000,
    config = function()
      require("catppuccin").setup()
      vim.cmd.colorscheme "catppuccin"
    end
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    version = '*',
    opts = {
      sort_by = 'case_sensitive',
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    },
    keys = {
      {"<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    },
  },
  
  -- Adds autopairs to (), {}, [], etc... 
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  -- Shortcut to adds comments  
  {
    'numToStr/Comment.nvim',
    opts = {},
    keys = {
      { 'gcc', mode = 'n', desc = 'Toggle line comment'},
      { 'gc', mode = {'n', 'v'}, desc = 'Toggle line/block comment'},
    },
  },

  -- Add git related signs to gutter, as well as utilities for mananging changes
  {
    'lewis6991/gitsigns.nvim',
    config = function()
    	require('gitsigns').setup()
  end,
  },

  {
    'nvzone/showkeys',
    cmd =  "ShowkeysToggle",
    opts = {
      position = "top-center",
      maxkeys = 5,
      show_count = false,
    },
 },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = true },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      -- Load telescope extensions
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
    keys = { 
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
      { "<leader>t", "<cmd>Telescope<CR>", desc = "Toggle Telescope" }
    }, 
  },

  -- Add git related signs to gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    config = function()
    	require('gitsigns').setup()
    end,
  },
  
  -- TreeSitter for better syntax highlighting and code understanding
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { 
          'c', 'cpp', 'python',
          'lua', 'vim', 'vimdoc', 'query',
          -- Add other languages you want to support here
          -- For example: 'javascript', 'typescript', 'rust', 'go', etc.
        },
        
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
         },
        },
      }
    end,
  },

    -- LSP Support
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      
      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
      
      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/lazydev.nvim' },
    },
  },
  
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      
      -- LSP completion capabilities
      { 'hrsh7th/cmp-nvim-lsp' },
      
      -- Additional user-friendly snippets
      { 'rafamadriz/friendly-snippets' },
      
      -- Path and buffer completions
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
      }
    end,
  },
  
  -- Mason setup with ensured installations
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        -- List of servers for mason to install
        ensure_installed = {
          'pyright',       -- Python language server
          'clangd',        -- C/C++ language server
          -- Add other language servers here as needed
          -- Examples:
          -- 'rust_analyzer', -- Rust
          -- 'gopls',         -- Go
          -- 'tsserver',      -- TypeScript/JavaScript
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true,
      }
      
      -- Setup lazydev for better Lua development (must be set up before lspconfig)
      require('lazydev').setup()
      
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Setup language servers
      lspconfig.pyright.setup {
        capabilities = capabilities,
      }
      
      lspconfig.clangd.setup {
        capabilities = capabilities,
      }
      
      -- Add keybindings for LSP functions
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          
          -- Buffer local mappings.
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  },
})

