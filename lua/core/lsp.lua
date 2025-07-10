vim.lsp.enable({
	"lua",
	"csharp",
    "typescript",
    "css",
    "php",
    "sql",
    "python"
})

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true,
	underline = true,
	update_in_insert = true,
})
