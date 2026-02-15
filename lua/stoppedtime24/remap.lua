vim.g.mapleader = " "
vim.g.localmapleader = " "

-- Disables arrow keys in normal mode, use for window navigation instead
vim.keymap.set('n', '<Left>', '<C-W>h')
vim.keymap.set('n', '<Up>', '<C-W>k')
vim.keymap.set('n', '<Right>', '<C-W>l')
vim.keymap.set('n', '<Down>', '<C-W>j')

-- Used to create new windows (vertical and horizontal)
vim.keymap.set('n', '<leader>nvw', '<C-W>s')
vim.keymap.set('n', '<leader>nhw', '<C-W>v')

-- Helps with closing buffers
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bD", function()
  local n = tonumber(vim.fn.input("Buffer number: "))
  if n then Snacks.bufdelete(n) end
end, { desc = "Delete Buffer by Number" })
