require("mason").setup();
require('mason-lspconfig').setup({
    --[[
    automatic_enable = {
        exclude = {
            "omnisharp",
        },
    },
    ]]
    ensure_installed = {
        'clangd',
        'cssls',
        'gopls',
        'lua_ls',
        'csharp_ls',
        'phpactor',
        'pyrefly', --'pyright',
        'sqlls',
        'vtsls',   --'ts_ls',
        'tailwindcss',
        'jdtls',
        'vue_ls',
        'html'
    },
    --[[
    handlers = {
        function(server_name)
            if server_name == "omnisharp" then return end
            require('lspconfig')[server_name].setup({})
        end,
    }
    ]]
})
