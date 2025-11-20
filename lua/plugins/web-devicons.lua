-- try to install to use with tree.nvim at first, but feels like netrw is enough.
return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("config.web_devicons_config")
	end,
}
