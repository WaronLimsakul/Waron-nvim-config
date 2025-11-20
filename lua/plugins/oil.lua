return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            use_default_keymaps = false,
            keymaps = {
                ["<CR>"] = "actions.select",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["-"] = {"actions.parent", mode = "n"},
            }
        },
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    }
}
