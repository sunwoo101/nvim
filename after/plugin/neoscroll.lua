require('neoscroll').setup({
    mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>' },
    duration_multiplier = 0.5,
})

local ns = require("neoscroll")

vim.keymap.set({ "n", "v" }, "<C-j>", function()
    ns.scroll(vim.wo.scroll, { move_cursor = true, duration = 200 }) -- like <C-d>
end, { silent = true })

vim.keymap.set({ "n", "v" }, "<C-k>", function()
    ns.scroll(-vim.wo.scroll, { move_cursor = true, duration = 200 }) -- like <C-u>
end, { silent = true })
