vim.opt.termguicolors = true

require("bufferline").setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get()
}

local mocha = require("catppuccin.palettes").get_palette "mocha"

require("bufferline").setup({
    options = {
        mode = "buffers",
        numbers = "ordinal",
        show_close_icon = false,
        show_buffer_close_icons = false,
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
    highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "italic", "bold" },
        custom = {
            all = {
                fill = { bg = "#000000" },
            },
            mocha = {
                background = { fg = mocha.text },
            },
            latte = {
                background = { fg = "#000000" },
            },
        },
    },
})
