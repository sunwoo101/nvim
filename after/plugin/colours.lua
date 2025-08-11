function Colours(colour)
    colour = colour or "catppuccin"
    vim.cmd.colorscheme(colour)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.api.nvim_set_hl(0, "LineNr", { fg = "#b4b4f4" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e0e0ff", bold = true })
end

Colours()
