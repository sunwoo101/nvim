require("mason").setup();
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'cssls',
        'gopls',
        'lua_ls',
        'omnisharp',
        'phpactor',
        'pyright', --'pyrefly',
        'sqlls',
        'vtsls',   --'ts_ls',
        'tailwindcss',
        'jdtls',
        'vue_ls',
        'html',
        'pylsp'
    },
})
