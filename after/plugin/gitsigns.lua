require('gitsigns').setup {
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 50,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = "      <author>, (<author_time:%d/%m/%Y>)",
}

vim.cmd [[highlight GitSignsCurrentLineBlame guifg=#94E2E6 gui=italic]]
