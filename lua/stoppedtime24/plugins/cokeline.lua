return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "stevearc/resession.nvim"
  },
  config = function()
    require('cokeline').setup()
    
    local map = vim.api.nvim_set_keymap
    map("n", "<Leader>fpb", "<Plug>(cokeline-focus-prev)", { silent = true })
    map("n", "<Leader>fnb", "<Plug>(cokeline-focus-next)", { silent = true })
    map("n", "<Leader>spb", "<Plug>(cokeline-switch-prev)", { silent = true })
    map("n", "<Leader>snb", "<Plug>(cokeline-switch-next)", { silent = true })
    map("n", "<Leader>bc", "<Plug>(cokeline-pick-close)", { silent = true })
    
    for i = 1, 9 do
      map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
    end
  end,
}
