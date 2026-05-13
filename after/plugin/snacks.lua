vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files({ hidden = true, ignored = true }) end,
    { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Live Grep" })


require("snacks").setup({
    image = {
        enabled = true,
        force_magick = false,
    },
    bigfile = { enabled = false },
    dashboard = { enabled = true },
    indent = { enabled = false },
    scope = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    --[[
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
    --]]
    statuscolumn = { enabled = false },
    words = { enabled = false },
    explorer = {
        enabled = true,
        replace_netrw = true,
        trash = true,
    },
    picker = {
        ui_select = true,
        layout = {
            cycle = false,
        },
        win = {
            list = {
                keys = {
                    ["<C-j>"] = { "list_scroll_down", mode = { "i", "n" } },
                    ["<C-k>"] = { "list_scroll_up", mode = { "i", "n" } },
                },
            },
        },
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

-- vtsls's getEditsForFileRename (used for import updates) only works on files that
-- are open in tsserver's buffer. Patch _rename so that any file not already open
-- gets a hidden buffer + vtsls attachment before workspace/didRenameFiles is sent.
local orig_rename = Snacks.rename._rename
Snacks.rename._rename = function(from, to)
    local ok = orig_rename(from, to)
    if ok and vim.fn.bufnr(to) < 0 then
        local buf = vim.fn.bufadd(to)
        vim.bo[buf].buflisted = false
        vim.fn.bufload(buf)
        for _, client in ipairs(vim.lsp.get_clients({ name = "vtsls" })) do
            vim.lsp.buf_attach_client(buf, client.id)
        end
        vim.defer_fn(function()
            if vim.api.nvim_buf_is_valid(buf) and not vim.bo[buf].buflisted then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end, 3000)
    end
    return ok
end
