local function macro_recording()
    local reg = vim.fn.reg_recording()
    if reg == '' then
        return ''
    else
        return 'recording @' .. reg
    end
end

-- Show active LSP client names for current buffer
local function lsp_attached()
    local bufnr = vim.api.nvim_get_current_buf()
    local ok, get_clients = pcall(function() return vim.lsp.get_clients end)
    local clients = ok and get_clients({ bufnr = bufnr }) or vim.lsp.get_active_clients({ bufnr = bufnr })

    if not clients or #clients == 0 then return "" end

    local names = {}
    for _, c in ipairs(clients) do
        table.insert(names, c.name)
    end
    if #names == 0 then return "" end
    return "LSP: " .. table.concat(names, ",")
end

vim.opt.showmode = false -- lualine shows mode anyway

require('lualine').setup {
    options = {
        icons_enabled = true,
        --theme = 'catppuccin',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16, -- ~60fps
            events = {
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
                'RecordingEnter',
                'RecordingLeave',
            },
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = { macro_recording },
        lualine_x = { lsp_attached },
        lualine_y = { 'filename' },
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
