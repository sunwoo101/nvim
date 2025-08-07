require("mason").setup();
require('mason-tool-installer').setup {
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
        'tailwindcss',
        'jdtls',
        'vue_ls',
        'html',
        'eslint',
        'prettier',
        'prettierd',
        'black',
        'pylint',
        'stylua',
        'phpcs',
        'sqlfluff'
    },
    auto_update = true,
    run_on_start = true,
    integrations = {
        ['mason-lspconfig'] = true,
    },
}
