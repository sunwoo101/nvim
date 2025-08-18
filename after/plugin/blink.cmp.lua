local function undobreak()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-g>u", true, false, true), "n", false)
end

require("blink.cmp").setup({
    keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Esc>"] = { "hide", "fallback" },
        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.accept({ callback = undobreak() })
                else
                    return cmp.select_and_accept({ callback = undobreak() })
                end
            end,
            'snippet_forward',
            'fallback'
        },
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
        ghost_text = { enabled = true, show_with_menu = true },
    },
    snippets = { preset = 'luasnip' },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "lua",
    },
    signature = { enabled = false },
})
