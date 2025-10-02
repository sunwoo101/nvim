require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
});
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'cssls',
        'gopls',
        'lua_ls',
        --'omnisharp', Install roslyn and rzls from Mason.
        'phpactor',
        --'pyright', --'pyrefly',
        'sqlls',
        'vtsls', --'ts_ls',
        'tailwindcss',
        'jdtls',
        'vue_ls',
        'html',
        'pylsp',
        'qmlls'
    },
})
