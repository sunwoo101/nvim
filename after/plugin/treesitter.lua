require('nvim-treesitter').setup {
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        disable = { "xml" },
    },
    indent = {
        enabled = false,
    },
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local ok, _ = pcall(vim.treesitter.start)
  end,
})
