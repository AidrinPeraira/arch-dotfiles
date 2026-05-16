return {
  -- add noctalia colorscheme support
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function()
      local colors_file = vim.fn.expand("~/.config/noctalia/colors.json")

      local function get_overrides()
        local f = io.open(colors_file, "r")
        local noctalia = {}
        if f then
          local content = f:read("*a")
          f:close()
          noctalia = vim.json.decode(content)
        end

        return {
          base = noctalia.mSurface or "#131316",
          mantle = noctalia.mSurfaceVariant or "#201f23",
          crust = noctalia.mShadow or "#000000",
          text = noctalia.mOnSurface or "#e5e1e6",
          subtext1 = noctalia.mOnSurfaceVariant or "#c7c5d0",
          subtext0 = noctalia.mOutline or "#46464f",
          overlay2 = noctalia.mOutline or "#46464f",
          overlay1 = noctalia.mOutline or "#46464f",
          overlay0 = noctalia.mOutline or "#46464f",
          surface2 = noctalia.mSurfaceVariant or "#201f23",
          surface1 = noctalia.mSurfaceVariant or "#201f23",
          surface0 = noctalia.mSurfaceVariant or "#201f23",

          lavender = noctalia.mPrimary or "#bfc2ff",
          blue = noctalia.mPrimary or "#bfc2ff",
          sapphire = noctalia.mPrimary or "#bfc2ff",
          sky = noctalia.mSecondary or "#c5c4dd",
          teal = noctalia.mSecondary or "#c5c4dd",
          green = noctalia.mSecondary or "#c5c4dd",
          yellow = noctalia.mTertiary or "#e8b9d5",
          peach = noctalia.mTertiary or "#e8b9d5",
          maroon = noctalia.mTertiary or "#e8b9d5",
          red = noctalia.mError or "#ffb4ab",
          mauve = noctalia.mHover or "#e8b9d5",
          pink = noctalia.mTertiary or "#e8b9d5",
          flamingo = noctalia.mTertiary or "#e8b9d5",
          rosewater = noctalia.mPrimary or "#bfc2ff", -- Changed from mOnSurface to avoid invisible highlights
        }
      end

      local options = {
        flavour = "mocha",
        transparent_background = false,
        color_overrides = {
          mocha = get_overrides(),
        },
        integrations = {
          telescope = { enabled = true },
          indent_blankline = { enabled = true, colored_indent_levels = false },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          treesitter = true,
          notify = true,
          mini = true,
          gitsigns = true,
          bufferline = true,
          blink_cmp = true,
          indent_blankline = { enabled = true },
          lualine = true,
          noice = true,
          which_key = true,
        },
      }

      local function reload_theme()
        options.color_overrides.mocha = get_overrides()
        require("catppuccin").setup(options)
        vim.cmd("colorscheme catppuccin")
      end

      -- Command to reload the theme manually
      vim.api.nvim_create_user_command("NoctaliaReload", reload_theme, {})

      -- Watch for changes in colors.json
      local uv = vim.uv or vim.loop
      local w = uv.new_fs_event()
      if w then
        w:start(
          colors_file,
          {},
          vim.schedule_wrap(function(err, filename, events)
            if err then
              return
            end
            reload_theme()
          end)
        )
      end

      return options
    end,
  },

  -- Configure LazyVim to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
