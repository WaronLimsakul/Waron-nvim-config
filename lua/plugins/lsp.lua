return {
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-path'},
	{"L3MON4D3/LuaSnip"},
    config = function()
        require("config.lsp_config")
    end
}
