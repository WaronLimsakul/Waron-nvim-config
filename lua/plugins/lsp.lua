return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },
        config = function()
            require("config.lsp_config")
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { { "roobert/tailwindcss-colorizer-cmp.nvim", config = true } },
        opts = function(_, opts)
            opts.formatting = {
                format = require("tailwindcss-colorizer-cmp").formatter,
            }
        end
    }
}
