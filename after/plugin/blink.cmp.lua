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
    cmdline = {
        enabled = true,         -- or remove if you had set it to false
        keymap = {
            preset = "inherit", -- start from your top-level keymap
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
        },
        completion = {
            menu = { auto_show = true }, -- optional: show popup automatically
        },
    },
    appearance = {
        nerd_font_variant = "mono",
        kind_icons = {
            Class         = "󰠱",
            Function      = "󰊕",
            Method        = "󰆧",
            Variable      = "󰀫",
            Field         = "󰈽",
            Property      = "",
            Interface     = "",
            Module        = "",
            File          = "",
            Folder        = "",
            Snippet       = "󰘍",
            Text          = "󰉿",
            Keyword       = "󰌋",
            Unit          = "",
            Value         = "󰎠",
            Enum          = "",
            Color         = "󰏘",
            Struct        = "",
            Event         = "",
            Operator      = "󰆕",
            TypeParameter = "",
        },
        source_labels = {
            lsp      = "[LSP]",
            path     = "[Path]",
            buffer   = "[Buffer]",
            snippets = "[Snip]",
        },
    },
    completion = {
        trigger = { show_in_snippet = true },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            update_delay_ms = 50,
            window = { border = "rounded" },
        },
        menu = {
            auto_show = true,
            border = "rounded"
        },
        ghost_text = { enabled = true, show_with_menu = true },
        accept = { auto_brackets = { enabled = true }, },
    },
    menu = {
        auto_show = true,

        -- nvim-cmp style menu
        draw = {
            columns = {
                { "label",     "label_description", gap = 1 },
                { "kind_icon", "kind" }
            },
        }
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
