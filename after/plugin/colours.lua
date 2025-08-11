function Colours(colour)
    colour = colour or "catppuccin"
    vim.cmd.colorscheme(colour)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.api.nvim_set_hl(0, "LineNr", { fg = "#cccc00" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#cccc00", bold = true })
end

Colours()
