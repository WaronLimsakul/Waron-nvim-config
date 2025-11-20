return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"dart",
				"c",
				"cpp",
				"go",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"heex",
				"javascript",
				"typescript",
				"tsx",
				"python",
				"html",
				"css",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
