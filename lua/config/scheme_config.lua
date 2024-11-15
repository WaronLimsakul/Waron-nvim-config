require("rose-pine").setup({
    variant = "main",
    dark_variant = "moon",

    enable = {
        legacy_highlights = true,
        migrations = true,
    },
    styles = {
        bold = true,
        italic = false,
        transparency = false,
    },

})
require("gruvbox").setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    -- no italic - I don't like it.
    italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})

vim.cmd("colorscheme gruvbox")
