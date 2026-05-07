require("hlchunk").setup({
    chunk    = {
        enable = true,
        style = { { fg = "#7b7bc8" } },
        duration = 0,
        delay = 0,
        straight = true,
    },
    indent   = {
        enable = true,
        style = { { fg = "#3b3b4f" } },
        chars = { "│" },
    },
    line_num = { enable = false },
    blank    = { enable = false },
})
