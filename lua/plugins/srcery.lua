return {
	-- thanks, Nick
	"srcery-colors/srcery-vim",
	config = function()
		vim.g.srcery_italic = 1
		vim.g.srcery_bold = 1
		vim.g.srcery_inverse = 0
		vim.g.srcery_undercurl = 1

		vim.cmd([[
			highlight Normal guibg=#000000 ctermbg=0
			highlight NormalNC guibg=#000000 ctermbg=0
			highlight SignColumn guibg=#000000 ctermbg=0
			highlight LineNr guibg=#000000 ctermbg=0
			highlight FoldColumn guibg=#000000 ctermbg=0
			highlight VertSplit guibg=#000000 ctermbg=0
			highlight StatusLine guibg=#000000 ctermbg=0
			highlight EndOfBuffer guibg=#000000 ctermbg=0
		]])
	end,
}
