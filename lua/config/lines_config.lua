vim.o.number = true
vim.o.relativenumber = true
-- Set the number of spaces for an indentation level
vim.o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.o.tabstop = 4 -- Number of spaces a tab counts for
vim.o.softtabstop = 4 -- How many spaces a tab feels like when editing
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.smartindent = true -- Automatically indent new lines

vim.o.signcolumn = "yes"

vim.opt.guicursor = {
	"a:blinkwait700-blinkoff400-blinkon250",
	"i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
}

-- highlight cursor green for insert mode
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "Cursor", { fg = "NONE", bg = "#3EB489" })
		vim.api.nvim_set_hl(0, "lCursor", { fg = "NONE", bg = "#3EB489" })
	end,
})

-- vim.opt.guicursor = {
-- 	"n-v-c:block-blinkwait700-blinkoff400-blinkon250",
-- 	"i:ver25-blinkwait700-blinkoff400-blinkon250",
-- }

vim.opt.hlsearch = false -- no highlight when search
vim.opt.incsearch = true -- make search more flexible.

vim.opt.termguicolors = true -- good colors, I guess
vim.opt.scrolloff = 8 -- when scrolling, you have 8 lines margin.

vim.opt.updatetime = 50 -- fast update time

vim.opt.colorcolumn = "80"
