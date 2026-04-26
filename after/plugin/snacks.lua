vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Live Grep" })

require("snacks").setup({
    image = {
        enabled = true,
        force_magick = false,
    },
    bigfile = { enabled = false },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = true },
    scroll = {
        enabled = true,
        animate = {
            duration = { step = 10, total = 100 }, -- Half the default speed (10/200)
            easing = "linear",                    -- Linear feels more consistent for fast scrolling
        },
        -- This makes repeated scrolling (holding j/k) even faster
        animate_repeat = {
            delay = 50, -- Start speed-up after 50ms of holding the key
            duration = { step = 3, total = 50 },
        },
    },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    explorer = {
        enabled = true,
        replace_netrw = true,
        trash = true,
    },
    picker = {
        sources = {
            explorer = {
                finder = "explorer",
                watch = true,
                highlights = true,
                diagnostics = true,
                diagnostics_open = true,
                git_status = true,
                git_status_open = true,
                git_untracked = true,
                auto_close = true,
                hidden = true,
                ignored = true,
                layout = {
                    preset = "sidebar",
                    layout = {
                        width = 0.5,
                    }
                },
                win = {
                    list = {
                        wo = {
                            number = true,
                            relativenumber = true,
                        },
                        keys = {
                            ["<CR>"] = "confirm",
                            ["o"] = "confirm",
                            ["q"] = "close",
                            ["a"] = "explorer_add",
                            ["d"] = "explorer_del",
                            ["r"] = "explorer_rename",
                            ["R"] = "explorer_update",
                            ["l"] = "explorer_focus", -- Change directory
                        },
                    },
                },
            },
        },
    },
})
