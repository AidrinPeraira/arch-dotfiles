return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  -- Load on standard Neovim events instead of the custom 'LazyFile'
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts = {
    indent = { enable = true },
    highlight = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
  },
  config = function(_, opts)
    -- This uses the clean setup API required by the latest main branch
    require("nvim-treesitter").setup(opts)
  end,
}
