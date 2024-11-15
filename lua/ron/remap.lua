vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true, desc = "format success" })

-- try visual the line then J or K, it will move the entire thing.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z") -- this one takes the line below and stick it to the back of this one
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- half page jump down
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- half page jump up
-- when search for something, use "n" to continue search with that word in in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv") -- likewise, use "N" to go back.

vim.keymap.set("x", "<leader>p", "\"_dP") -- delete highlight word and paste buffer word without change buffer.

vim.keymap.set("n", "<leader>y", "\"+y") -- copy  to clipboard
vim.keymap.set("v", "<leader>y", "\"+y") -- copy to clipboard in visual mode.
