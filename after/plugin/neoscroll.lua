--[[
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
]]

-- Move cursor half-page down (respects scrolloff)
vim.keymap.set({ "n", "v" }, "<C-j>", function()
  local lines = math.floor(vim.fn.winheight(0) / 2)
  return "m'" .. lines .. "j"
end, { expr = true, silent = true, desc = "Half-page down with cursor movement" })

-- Move cursor half-page up (respects scrolloff)
vim.keymap.set({ "n", "v" }, "<C-k>", function()
  local lines = math.floor(vim.fn.winheight(0) / 2)
  return "m'" .. lines .. "k"
end, { expr = true, silent = true, desc = "Half-page up with cursor movement" })
