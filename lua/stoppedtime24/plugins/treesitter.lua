return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  tag = 'v0.10.0',
  event = { "VeryLazy" },
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts_extend = { "ensure_installed" },
  ---@alias lazyvim.TSFeat { enable?: boolean, disable?: string[] }
  ---@class lazyvim.TSConfig: TSConfig
  opts = {
    -- LazyVim config for treesitter
    indent = { enable = true }, ---@type lazyvim.TSFeat
    highlight = { enable = true }, ---@type lazyvim.TSFeat
    folds = { enable = true }, ---@type lazyvim.TSFeat
    ensure_installed = {
      "c",
      "cpp",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "vim",
      "vimdoc",
    },
  },
}
