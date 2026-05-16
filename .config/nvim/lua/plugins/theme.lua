return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			styles = {
				transparency = true, -- Removes the theme's background entirely
			}
		})
		vim.cmd("colorscheme rose-pine-moon")
	end
}
