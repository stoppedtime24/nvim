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

-- Enable catppuccin plugin
-- vim.cmd.colorscheme "catppuccin"

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

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    depedencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fm.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim'},

      {'nvim-tree/nvim-web-devicons', enabled = true},
    },
    keys = { 
      { "<leader>T", "<cmd>Telescope<CR>", desc = "Toggle Telescope" }
    }, 
  },

  -- Add git related signs to gutter, as well as utilities for mananging changes
  {
    'lewis6991/gitsigns.nvim',
    config = function()
    	require('gitsigns').setup()
  end,
  },
})

