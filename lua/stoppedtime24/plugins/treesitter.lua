return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  event = { "VeryLazy" },
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
--  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
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
