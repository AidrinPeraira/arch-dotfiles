return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- Disable virtual text (inline) completely to avoid clutter and overflow
        virtual_text = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          max_width = 100,
          -- Ensure text wraps inside the floating window
          wrap = true,
        },
      },
      servers = {
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
            },
            typescript = {
              preferences = {
                -- This forces the use of @/* aliases instead of relative paths
                importModuleSpecifierPreference = "non-relative",
                -- This prevents the addition of .js or .ts extensions
                importModuleSpecifierEnding = "minimal",
              },
            },
            javascript = {
              preferences = {
                importModuleSpecifierPreference = "non-relative",
                importModuleSpecifierEnding = "minimal",
              },
            },
          },
        },
      },
    },
  },
}
