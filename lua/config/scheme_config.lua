require("rose-pine").setup({
	variant = "main",
	dark_variant = "moon",

	enable = {
		legacy_highlights = true,
		migrations = true,
	},
	styles = {
		bold = true,
		italic = false,
		transparency = false,
	},

})

vim.cmd("colorscheme rose-pine")
