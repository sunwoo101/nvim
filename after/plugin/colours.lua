require("catppuccin").setup({
    flavour = "mocha", -- or latte/frappe/macchiato
    transparent_background = true,
    -- ...your other options...
    custom_highlights = function(cp)
        return {
            LineNr                              = { fg = cp.overlay0 },
            CursorLineNr                        = { fg = cp.lavender, bold = true },

            -- Transparent tabs
            BufferLineFill                      = { bg = "none" },
            BufferLineBackground                = { bg = "none" },
            BufferLineTab                       = { bg = "none" },
            BufferLineTabClose                  = { bg = "none" },
            BufferLineBufferSelected            = { bg = "none" },
            BufferLineBufferVisible             = { bg = "none" },
            BufferLineSeparator                 = { bg = "none" },
            BufferLineSeparatorSelected         = { bg = "none" },
            BufferLineCloseButton               = { bg = "none" },
            BufferLineCloseButtonVisible        = { bg = "none" },
            BufferLineCloseButtonSelected       = { bg = "none" },
            BufferLineModified                  = { bg = "none" },
            BufferLineModifiedVisible           = { bg = "none" },
            BufferLineModifiedSelected          = { bg = "none" },
            BufferLineIndicatorSelected         = { bg = "none", fg = cp.lavender },
            BufferLineIndicatorVisible          = { bg = "none" },
            BufferLineIndicator                 = { bg = "none" },
            BufferLineDiagnostic                = { bg = "none" },
            BufferLineDiagnosticVisible         = { bg = "none" },
            BufferLineDiagnosticSelected        = { bg = "none" },
            BufferLineInfoVisible               = { bg = "none" },
            BufferLineInfoSelected              = { bg = "none" },
            BufferLineNumbers                   = { bg = "none" },
            BufferLineNumbersVisible            = { bg = "none" },
            BufferLineNumbersSelected           = { bg = "none" },
            BufferLineErrorDiagnosticVisible    = { bg = "none" },
            BufferLineErrorDiagnosticSelected   = { bg = "none" },
            BufferLineInfoDiagnosticVisible     = { bg = "none" },
            BufferLineInfoDiagnosticSelected    = { bg = "none" },
            BufferLineHintDiagnosticVisible     = { bg = "none" },
            BufferLineHintDiagnosticSelected    = { bg = "none" },

            BufferLineWarningVisible            = { bg = "none" },
            BufferLineWarningSelected           = { bg = "none" },
            BufferLineWarningDiagnosticVisible  = { bg = "none" },
            BufferLineWarningDiagnosticSelected = { bg = "none" },
            BufferLineErrorVisible              = { bg = "none" },
            BufferLineErrorSelected             = { bg = "none" },
            BufferLineHintVisible               = { bg = "none" },
            BufferLineHintSelected              = { bg = "none" },

            BufferLineError                     = { fg = cp.red, bg = "none" },
            BufferLineErrorDiagnostic           = { fg = cp.red, bg = "none" },

            BufferLineWarning                   = { fg = cp.yellow, bg = "none" },
            BufferLineWarningDiagnostic         = { fg = cp.yellow, bg = "none" },

            BufferLineHint                      = { fg = cp.teal, bg = "none" },
            BufferLineHintDiagnostic            = { fg = cp.teal, bg = "none" },

            BufferLineInfo                      = { fg = cp.sky, bg = "none" },
            BufferLineInfoDiagnostic            = { fg = cp.sky, bg = "none" },
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
