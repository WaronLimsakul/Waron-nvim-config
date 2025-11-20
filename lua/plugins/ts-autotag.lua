return {
    "windwp/nvim-ts-autotag",
    ft = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "html",
    },
    config = function()
        require("nvim-ts-autotag").setup()
    end
}

