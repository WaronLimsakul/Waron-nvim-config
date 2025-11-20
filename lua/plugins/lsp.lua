return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason-lspconfig").setup({
			handlers = {
				["clangd"] = function()
					require("lspconfig").clangd.setup({
						capabilities = capabilities,
						cmd = {
							"clangd",
							"--background-index",
							"--clang-tidy",
							-- The key flag to enable C++20 modules support:
							"--experimental-modules-support",
						},
						init_options = {
							fallbackFlags = {
								"-std=c++20",
							},
						},
					})
				end,
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
		vim.diagnostic.setqflist()
		-- vim.diagnostic.config({
		-- 	virtual_text = true,
		-- 	-- virtual_lines = { current_line = true },
		-- 	-- underline = true,
		-- 	-- update_in_insert = false,
		-- })

		-- normal hover, gotta set it here to make sure I override
		-- the old config.
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({
				focusable = false,
				style = "minimal",
				border = "rounded",
			})
		end, { desc = "LSP Hover" })
	end,
}
