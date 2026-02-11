return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
	commit = '47f91c4',
	    config = function()
	      require('lualine').setup {
		options = {
		  theme = 'everforest',
			icons_enabled = true
		},
		sections = {
				lualine_b = {
					{
						'branch', 
						color = {fg = 'white', gui = 'bold'},
						padding = 2,
					},
					{ 'diff', padding = 2}
				},
			}
	      }
	end,
}
