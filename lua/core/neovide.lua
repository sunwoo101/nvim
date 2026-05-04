vim.g.neovide_opacity = 0.7
vim.g.neovide_window_blurred = true
vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.g.neovide_refresh_rate = 300
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"

if vim.g.neovide then
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
    end

    local is_mac = vim.fn.has("macunix") == 1
    local copy_key   = is_mac and "<D-c>" or "<C-S-c>"
    local cut_key    = is_mac and "<D-x>" or "<C-S-x>"
    local paste_key  = is_mac and "<D-v>" or "<C-S-v>"

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
    map("n", zoom_in,  function() scale(1.1) end, "Zoom in")
    map("n", zoom_out, function() scale(1 / 1.1) end, "Zoom out")
    map("n", zoom_rst, function() vim.g.neovide_scale_factor = 1.0 end, "Reset zoom")
end
