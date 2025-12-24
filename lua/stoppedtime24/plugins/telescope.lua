return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    'nvim-telescope/telescope-fzf-native.nvim',
    {'nvim-tree/nvim-web-devicons', enabled = true},
  },
  keys = {
    {"<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files"},
    {"<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep"},
    {"<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers"},
    {"<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags"},
    {"<leader>tt", "<cmd>Telescope<CR>", desc = "Toggle Telescope"},
  },
}
