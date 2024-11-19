require("fidget").setup()
require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")
local on_attach = function(_, _)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {}) -- rename everything you choose
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})                   -- Go to definition
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})               -- go to implementation
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {}) -- go to references
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
end
local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- Luasnip expands snippets
        end,
    },
    mapping = cmp.mapping.preset.insert({ -- try setting this to debug the auto completion
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),

    }),
})
local servers = { "lua_ls", "html", "cssls", "ts_ls", "pylsp", "clangd", "omnisharp", "jdtls", "jsonls", "marksman",
    "eslint", "tailwindcss" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities
    })
end
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }, -- let lua_ls recognize vim in global scope, so no warning.
            },
        },
    },
})
