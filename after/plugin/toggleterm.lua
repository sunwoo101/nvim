require("toggleterm").setup({
    direction = "float",
    persist_mode = false,
    float_opts = {
        border = "rounded",
        width = function() return math.floor(vim.o.columns * 0.9) end,
        height = function() return math.floor(vim.o.lines * 0.9) end,
    },
    open_mapping = nil,
})

local function toggle_float_term()
    require("toggleterm").toggle(1, nil, nil, "float")
end

vim.keymap.set({ "n", "t" }, "<C-CR>", toggle_float_term, { silent = true, desc = "Toggle float terminal" })
