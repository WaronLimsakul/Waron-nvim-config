vim.opt.backupcopy = "yes"

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "dart", "typescriptreact", "javascriptreact" },
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
		vim.bo.softtabstop = 2
		vim.bo.expandtab = true
		vim.bo.smartindent = true
	end,
})

vim.loader.enable()
vim.opt.swapfile = false
vim.opt.shada = "'100,<50,s10,h,f1,n~/.local/share/nvim/shada/minimal.shada"
