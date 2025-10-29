vim.opt.termguicolors = true

require("bufferline").setup({
    options = {
        mode = "buffers",
        numbers = "ordinal",
        show_close_icon = false,
        show_buffer_close_icons = false,
        separator_style = "none",
        diagnostics = "nvim_lsp",
        indicator = { style = "icon" },
        --[[
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
        ]]
        modified_icon = "●",
    },
})
