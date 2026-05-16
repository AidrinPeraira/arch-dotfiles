return {
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = {
        exclude = { "svg" },
      },
      image = {
        enabled = true,
        env = { SNACKS_KITTY = "true" },
      },
      explorer = {
        hidden = true,
        ignored = true,
      },
    },
  },
}
