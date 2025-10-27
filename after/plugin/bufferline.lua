vim.opt.termguicolors = true

local ok, catppuccin_integration = pcall(require, "catppuccin.groups.integrations.bufferline")
if not ok then
    vim.notify("Catppuccin bufferline integration not found", vim.log.levels.WARN)
    return
end

local mocha = require("catppuccin.palettes").get_palette "mocha"

require("bufferline").setup({
    options = {
        mode = "buffers",
        numbers = "ordinal",
        show_close_icon = false,
        show_buffer_close_icons = true,
        separator_style = "thin",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diagnostics_dict, _)
            local s = ""
            if diagnostics_dict.error then
                s = s .. " " .. diagnostics_dict.error .. " "
            end
            if diagnostics_dict.warning then
                s = s .. " " .. diagnostics_dict.warning
            end
            return s
        end,
        modified_icon = "●",
    },
    highlights = catppuccin_integration.get_theme {
        styles = { "italic", "bold" },
        custom = {
            all = {
                fill = { bg = "#000000" },
            },
            mocha = {
                background = { fg = mocha.text },
            },
        },
    },
})
