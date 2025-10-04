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
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enabled = false,
    },
    yati = {
        enable = true,

        -- Whether to enable lazy mode (recommend to enable this if bad indent happens frequently)
        default_lazy = true,

        -- Determine the fallback method used when we cannot calculate indent by tree-sitter
        --   "auto": fallback to vim auto indent
        --   "asis": use current indent as-is
        --   "cindent": see `:h cindent()`
        -- Or a custom function return the final indent result.
        default_fallback = "auto"
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
