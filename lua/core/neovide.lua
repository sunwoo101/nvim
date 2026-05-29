vim.g.neovide_opacity = 0.6
vim.g.neovide_window_blurred = true
vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.g.neovide_refresh_rate = 300
vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono:h12"

local adhd = true

if adhd then
    vim.g.neovide_cursor_vfx_mode = "railgun" -- railgun | torpedo | pixiedust | sonicboom | ripple | wireframe
    vim.g.neovide_cursor_vfx_opacity = 200.0
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
    vim.g.neovide_cursor_vfx_particle_density = 3.0
    vim.g.neovide_cursor_vfx_particle_speed = 10.0
    vim.g.neovide_cursor_vfx_particle_phase = 1.0
    vim.g.neovide_cursor_vfx_particle_curl = 1.0

    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*:[iRt]*",
        callback = function() vim.g.neovide_cursor_vfx_mode = "ripple" end,
    })
    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "[iRt]*:*",
        callback = function() vim.g.neovide_cursor_vfx_mode = "railgun" end,
    })
end

if vim.g.neovide then
    -- Float surfaces in Neovide are pre-filled with a dark default colour regardless
    -- of highlight groups. winblend=100 fully blends each float with the transparent
    -- main window so the OS desktop shows through. Text fg is unaffected by winblend.
    -- WinNew + vim.schedule ensures we run after the window is fully constructed;
    -- we scan all floats so backdrop/utility windows are also caught.
    local augroup = vim.api.nvim_create_augroup("NeovideFloatTransparency", { clear = true })
    vim.api.nvim_create_autocmd("WinNew", {
        group = augroup,
        callback = function()
            vim.schedule(function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_is_valid(win) then
                        local cfg = vim.api.nvim_win_get_config(win)
                        if cfg.relative ~= "" then
                            vim.wo[win].winblend = 100
                        end
                    end
                end
            end)
        end,
    })

    -- winblend=100 makes ALL cell backgrounds transparent, including CursorLine.
    -- blend=0 on a highlight group overrides the window winblend for that group,
    -- so these backgrounds render at full opacity even inside winblend=100 windows.
    local function fix_blend_overrides()
        local groups = { "CursorLine", "CursorLineNr", "Visual", "VisualNOS" }
        for _, g in ipairs(groups) do
            local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = g, link = false })
            if ok and hl then
                hl.blend = 0
                vim.api.nvim_set_hl(0, g, hl)
            end
        end
    end
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = augroup,
        callback = fix_blend_overrides,
    })
    fix_blend_overrides()

    local map       = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
    end

    local is_mac    = vim.fn.has("macunix") == 1
    local copy_key  = is_mac and "<D-c>" or "<C-S-c>"
    local cut_key   = is_mac and "<D-x>" or "<C-S-x>"
    local paste_key = is_mac and "<D-v>" or "<C-S-v>"

    map({ "n", "v" }, copy_key, '"+y', "Copy to clipboard")
    map({ "n", "v" }, cut_key, '"+d', "Cut to clipboard")
    map({ "n", "v", "s", "x", "o", "l", "c", "t" }, paste_key, function()
        vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
    end, "Paste from clipboard")
    map("i", paste_key, "<C-r>+", "Paste from clipboard")
    map("c", paste_key, "<C-r>+", "Paste from clipboard")

    map("t", "<S-CR>", function()
        vim.api.nvim_chan_send(vim.bo.channel, "\27\r")
    end, "Shift+Enter -> newline in terminal")

    vim.g.neovide_scale_factor = 1.0
    local function scale(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    local zoom_in  = is_mac and "<D-=>" or "<C-=>"
    local zoom_out = is_mac and "<D-->" or "<C-->"
    local zoom_rst = is_mac and "<D-0>" or "<C-0>"
    map("n", zoom_in, function() scale(1.1) end, "Zoom in")
    map("n", zoom_out, function() scale(1 / 1.1) end, "Zoom out")
    map("n", zoom_rst, function() vim.g.neovide_scale_factor = 1.0 end, "Reset zoom")
end
