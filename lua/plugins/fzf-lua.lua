return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	config = function()
		local actions = require("fzf-lua").actions
		require("fzf-lua").setup({
			-- "ivy",
			defaults = {
				git_icons = false,
				file_icons = true,
				color_icons = true,
			},

			winopts = {
				height = 0.95,
				width = 0.90,
				preview = {
					layout = "vertical",
					-- default = "bat",
				},
			},

			keymap = {
				builtin = {
					["<C-u>"] = "preview-page-up",
					["<C-d>"] = "preview-page-down",
				},
			},

			actions = {
				files = {
					true,
					["ctrl-q"] = actions.file_sel_to_qf,
				},
			},
		})

		vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "fzf files" })
		vim.keymap.set("n", "<leader>fl", require("fzf-lua").live_grep_native, { desc = "fzf live grep" })
		vim.keymap.set("n", "<leader>fs", require("fzf-lua").grep, { desc = "fzf grep" })
		vim.keymap.set("n", "<leader>fr", require("fzf-lua").resume, { desc = "fzf resume" })
		vim.keymap.set("n", "<leader>fw", require("fzf-lua").grep_cword, { desc = "fzf find word under cursor" })
		vim.keymap.set("v", "<leader>fv", require("fzf-lua").grep_visual, { desc = "fzf find word under visual" })
	end,
}
