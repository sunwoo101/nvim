require("mason").setup();
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'cssls',
        'gopls',
        'lua_ls',
        'omnisharp',
        'phpactor',
        'pyrefly', --'pyright',
        'sqlls',
        'vtsls',   --'ts_ls',
        'tailwindcss',
        'jdtls',
        'vue_ls',
        'html'
    },
})
