return {
	"stevearc/conform.nvim",
	config = function()
		-- vim.filetype.add({
		-- 	extension = {
		-- 		ipynb = "ipynb",
		-- 	},
		-- })
		require("conform").setup({
			formatters = {
				notebook_formatter = {
					command = "python3",
					args = { vim.fn.expand("~/Custom/Formatter/format_notebook.py") },
					stdin = true,
				},
				["clang-format"] = {
					prepend_args = { "-style={BasedOnStyle: Google, IndentWidth: 4}" },
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				-- You can customize some of the format options for the filetype (:help conform.format)
				-- Conform will run the first available formatter
				yaml = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				rust = { lsp_format = "fallback" },
				go = { "gofmt" },
				cpp = { "clang-format" },
				c = { "clang-format" },

				json = function(bufnr)
					local file_name = vim.api.nvim_buf_get_name(bufnr)
					if file_name:match("%.ipynb$") then
						return { "notebook_formatter" }
					else
						return { "prettierd" }
					end
				end,
				-- { "prettierd", "notebook_formatter", stop_after_first = false },
				-- ipynb = { "notebook_formatter" },
				dart = { lsp_format = "fallback" },
			},
			format_on_save = {
				timeout_ms = 1000,
			},
		})
	end,
}
