require("mason").setup();
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'cssls',
        'gopls',
        'lua_ls',
        'omnisharp',
        'phpactor',
        'pyright',
        'sqlls',
        'ts_ls',
        'tailwindcss'
    },
})
