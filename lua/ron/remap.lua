vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>f", function()
--     vim.lsp.buf.format({ async = true })
-- end, { noremap = true, silent = true, desc = "format success" })

-- try visual the line then J or K, it will move the entire thing.
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z") -- this one takes the line below and stick it to the back of this one
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- half page jump down
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- half page jump up
-- when search for something, use "n" to continue search with that word in in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv") -- likewise, use "N" to go back.

vim.keymap.set("x", "<leader>p", '"_dP') -- delete highlight word and paste buffer word without change buffer.

vim.keymap.set("n", "<leader>y", '"+y') -- copy  to clipboard
vim.keymap.set("v", "<leader>y", '"+y') -- copy to clipboard in visual mode.

vim.keymap.set("n", "<leader>d", '"_d') -- delete somethig and send to the void register.
vim.keymap.set("v", "<leader>d", '"_d') -- likewise, but in visual mode.

vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz", { desc = "Next Issue" }) -- jump to next quick fix (apply globally)
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz", { desc = "Previous Issue" }) -- likewise, but previous
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- jump to next location list (locally)
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") -- likewise, but previous

-- can replace a word that we are on. (change all over the file)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>s", [["hy:%s/\V<C-r>h/<C-r>h/gI<Left><Left><Left>]])
-- make the current file execuatable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- search word in same file, that's it
vim.keymap.set("v", "<leader>/", [["hy/<C-r>h<CR>]], { desc = "Search for visual selection" })
vim.keymap.set("n", "<leader>/", [[/\<<C-r><C-w>\><CR>]], { desc = "Search for word under cursor" })

local opts1 = { noremap = true, silent = true }
vim.keymap.set("v", "<Tab>", ">gv", opts1) -- tab chunk
vim.keymap.set("v", "<S-Tab>", "<gv", opts1) -- shift-tab to go back

vim.keymap.set("n", "-", "<CMD>Oil<CR>")

vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end)

-- reading diagnostic message
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic message" })

vim.keymap.set("n", "<leader>q", "@q")

vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", { desc = "Quickfix Open" })
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Quickfix Close" })
