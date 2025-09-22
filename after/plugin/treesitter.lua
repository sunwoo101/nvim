require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "go",
        "python",
        "java",
        "javascript",
        "typescript",
        "vue",
        "swift",
        "c_sharp",
        "css",
        "php",
        "sql",
        "c",
        "html",
        "cpp",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enabled = true,
    },
}

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    pattern = "python",
    callback = function()
        if pcall(function()
                return require("nvim-treesitter.parsers").has_parser("python")
            end) then
            vim.bo.indentexpr = "nvim_treesitter#indent()"
        end
    end,
})
