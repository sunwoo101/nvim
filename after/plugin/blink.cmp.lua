require("blink.cmp").setup({
    keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Esc>"] = { "hide", "fallback" },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        trigger = { show_in_snippet = true },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            update_delay_ms = 50
        },
        menu = { auto_show = true },
        ghost_text = { enabled = false, show_with_menu = true },
    },
    snippets = { preset = 'luasnip' },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
    signature = { enabled = false },
})
