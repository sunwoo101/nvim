vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        vim.lsp.buf.format({ bufnr = args.buf })
    end,
})
