require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
});

require("mason-lspconfig").setup {
    automatic_enable = {
        exclude = {
            "postgres_lsp"
        }
    }
}

require('mason-tool-installer').setup({
    ensure_installed = {
        'clangd',
        'cssls',
        'gopls',
        'lua_ls',
        'phpactor',
        'basedpyright', --'pyright', --'pyrefly',
        'postgres_lsp', -- sqlls
        'vtsls',        --'ts_ls',
        'tailwindcss',
        'jdtls',
        'vue_ls',
        'html',
        'pylsp',
        'qmlls',
        "xcode-build-server",
        "roslyn",
    },
    auto_update = true,
    run_on_start = true,
})
