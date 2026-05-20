return {
  "windwp/nvim-ts-autotag",
  -- Triggers right before a file is read or created, so it's ready when you type tags
  event = { "BufReadPre", "BufNewFile" }, 
  opts = {}, -- This automatically calls require("nvim-ts-autotag").setup({}) behind the scenes
}
