return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    floating_window = true, -- Show a popup with the signature
    hint_enable = true,     -- Also show virtual text next to the cursor
    hint_prefix = "󰏪 ",    -- Icon for the hint
    handler_opts = {
      border = "rounded",
    },
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}
