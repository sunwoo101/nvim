require("mason").setup();
require("mason-lspconfig").setup {
  automatic_installation = false,
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
  },
}
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
        'eslint_d',
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
-- conform.nvim setup
require("conform").setup({
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    vue = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    lua = { "stylua" },
    python = { "black" },
    php = { "phpcbf" },
    sql = { "sqlfluff" },
  },
})

-- nvim-lint setup
local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  python = { "pylint" },
  php = { "phpcs" },
}

-- Auto-run linter on save
vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

