vim.lsp.enable({
    "clangd",
    "cssls",
    "gopls",
    "lua_ls",
    "omnisharp",
    "phpactor",
    "prettier",
    "pyright",
    "sqlls",
    "tailwindcss",
    "ts_ls"
})

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true,
	underline = true,
	update_in_insert = true,
})
