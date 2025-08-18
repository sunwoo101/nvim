require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    auto_close = true,
    open_on_tab = false,
    update_cwd = true,
    diagnostics = {
        enable = true,
    },
    view = {
        width = 30,
        side = "right",
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
})
