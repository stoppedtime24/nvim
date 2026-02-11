return {
	"nvim-tree/nvim-tree.lua",
	tag = 'v.1.15.0',
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = true,
	keys = {
		{"<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle nvim tree"},
	},
	opts = {
		git = {
			enable = true,
		},
    filters = {
      dotfiles = true,
    },
	},	
}
