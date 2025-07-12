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
        'ts_ls'
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})
