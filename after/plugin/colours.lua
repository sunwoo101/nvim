require("catppuccin").setup({
    flavour = "mocha", -- or latte/frappe/macchiato
    transparent_background = true,
    -- ...your other options...
    custom_highlights = function(cp)
        return {
            LineNr       = { fg = cp.overlay0 },
            CursorLineNr = { fg = cp.lavender, bold = true },
        }
    end,
})
vim.cmd.colorscheme("catppuccin")

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 1) kill the transparency that creates the shade difference
vim.o.pumblend = 0
vim.o.winblend = 0

-- 2) make float windows/borders inherit your main background
--    (so rounded corners don't sit on a different-colored box)
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })

-- 3) make blink’s menu/doc use the same background as the editor
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })


-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#b4b4f4" })
-- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e0e0ff", bold = true })
-- vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#a4abbf", italic = true })
