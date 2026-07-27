vim.filetype.add({
	extension = {
		prisma = "prisma",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "prisma",
	callback = function()
		vim.treesitter.start()
	end,
})

require("config.options")
require("config.keymaps")
require("config.lazy")

-- Load dynamic colors from Matugen if they exist
pcall(require, "config.matugen")
