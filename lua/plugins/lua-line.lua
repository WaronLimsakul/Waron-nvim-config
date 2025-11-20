return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Minimal yet beautiful lualine configuration
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto", -- adapts to your colorscheme
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true, -- single statusline for all windows
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					{
						"diff",
						colored = true,
						symbols = { added = " ", modified = " ", removed = " " },
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = false,
						path = 1, -- relative path
						shorting_target = 40,
						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed = "[No Name]",
							newfile = "[New]",
						},
					},
					{
						"diagnostics",
						sources = { "nvim_lsp", "nvim_diagnostic" },
						sections = { "error", "warn", "info" },
						symbols = { error = " ", warn = " ", info = " " },
						colored = true,
						update_in_insert = false,
						always_visible = false,
					},
				},
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {
				"neo-tree",
				"lazy",
				"mason",
				"trouble",
				"quickfix",
			},
		})
	end,
}
