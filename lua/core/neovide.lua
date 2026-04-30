vim.g.neovide_opacity = 0.7
vim.g.neovide_window_blurred = true
vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.g.neovide_refresh_rate = 300
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"

if vim.g.neovide then
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
    end

    map({ "n", "v" }, "<C-S-c>", '"+y', "Copy to clipboard")
    map({ "n", "v" }, "<C-S-x>", '"+d', "Cut to clipboard")
    map({ "n", "v", "s", "x", "o", "l", "c", "t" }, "<C-S-v>", function()
        vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
    end, "Paste from clipboard")
    map("i", "<C-S-v>", "<C-r>+", "Paste from clipboard")
    map("c", "<C-S-v>", "<C-r>+", "Paste from clipboard")

    map("t", "<S-CR>", function()
        vim.api.nvim_chan_send(vim.bo.channel, "\27\r")
    end, "Shift+Enter -> newline in terminal")

    vim.g.neovide_scale_factor = 1.0
    local function scale(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    map("n", "<C-=>", function() scale(1.1) end, "Zoom in")
    map("n", "<C-->", function() scale(1 / 1.1) end, "Zoom out")
    map("n", "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, "Reset zoom")
end
