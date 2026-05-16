return {
  -- 1. THE ONLY CODING FEATURE YOU NEED: AUTO-COMPLETION
  {
    "Saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },

  -- 2. LUA DEVELOPER ENVIRONMENT ENGINE (Cleaned up)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        -- Native async I/O library completion (vim.uv)
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- Auto-completes your standalone snacks.nvim tools
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },

  -- 3. MASON PACKAGE MANAGER
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { "stylua", "shfmt" },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end)
    end,
  },

  -- 4. CORE LSP CONFIGURATION ENGINE
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 
      "mason-org/mason.nvim",
      "Saghen/blink.cmp",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      },
      inlay_hints = { enabled = true },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              -- NOTE: "vim" and "Snacks" are now handled safely via lazydev
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
            },
          },
        },
        ts_ls = {},
        vtsls = {},
        html = {},
        dockerls = {},
        jsonls = {},
      },
    },
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("gr", vim.lsp.buf.references, "References")
          map("gI", vim.lsp.buf.implementation, "Goto Implementation")
          map("gy", vim.lsp.buf.type_definition, "Goto Type Definition")
          map("K", vim.lsp.buf.hover, "Hover Info")
          map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>cl", function() Snacks.picker.lsp_config() end, "Lsp Info")
          map("<leader>cR", function() Snacks.rename.rename_file() end, "Rename File")
        end,
      })

      if opts.inlay_hints.enabled then
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client and client:supports_method("textDocument/inlayHint") then
              vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            end
          end,
        })
      end

      -- Modern Native Core Setup Loop
      for server_name, server_opts in pairs(opts.servers) do
        local capabilities = require("blink.cmp").get_lsp_capabilities(server_opts.capabilities)
        server_opts.capabilities = capabilities

        vim.lsp.config(server_name, server_opts)
        vim.lsp.enable(server_name)
      end
    end,
  },
}

