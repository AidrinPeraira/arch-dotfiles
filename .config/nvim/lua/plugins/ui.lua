return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Show line diagnostics automatically in hover window
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          })
        end,
      })
    end,
  },
}
