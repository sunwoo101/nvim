require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
    },
    format_on_save = {
        lsp_fallback = true, -- use LSP if no formatter available
        async = false,
        timeout_ms = 500,
    },
})
