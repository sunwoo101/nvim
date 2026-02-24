require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
});
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
    ensure_installed = {
        'clangd',
        'cssls',
        'gopls',
        'lua_ls',
        'phpactor',
        'basedpyright', --'pyright', --'pyrefly',
        'sqlls',
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
