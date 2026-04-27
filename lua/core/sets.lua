# neovide
vim.g.neovide_opacity = 0.7
vim.g.neovide_window_blurred = true
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"

-- Terminal colors (match kitty)
vim.g.terminal_color_0  = "#38383F"
vim.g.terminal_color_8  = "#ABA8A1"
vim.g.terminal_color_1  = "#99A0D3"
vim.g.terminal_color_9  = "#99A0D3"
vim.g.terminal_color_2  = "#D7ADD1"
vim.g.terminal_color_10 = "#D7ADD1"
vim.g.terminal_color_3  = "#67CFF9"
vim.g.terminal_color_11 = "#67CFF9"
vim.g.terminal_color_4  = "#E2DFEF"
vim.g.terminal_color_12 = "#E2DFEF"
vim.g.terminal_color_5  = "#D8F7FC"
vim.g.terminal_color_13 = "#D8F7FC"
vim.g.terminal_color_6  = "#FAF1DF"
vim.g.terminal_color_14 = "#FAF1DF"
vim.g.terminal_color_7  = "#F4F0E7"
vim.g.terminal_color_15 = "#F4F0E7"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autoread = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
    end,
})

vim.opt.fillchars:append({ eob = ' ' })

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.o.cmdheight = 0
vim.o.more = false
vim.o.showmode = true
vim.opt.cursorline = true

-- finer-grained undo like VSCode
local imap = function(lhs, rhs) vim.keymap.set("i", lhs, rhs, { silent = true }) end

-- break on common boundaries
for _, key in ipairs({ " ", ",", ".", ";", ":", "!", "?", "(", ")", "[", "]", "{", "}" }) do
    imap(key, "<C-g>u" .. key)
end
imap("<CR>", "<C-g>u<CR>")

-- break when moving the cursor in insert mode
for _, key in ipairs({ "<Left>", "<Right>", "<Up>", "<Down>", "<Home>", "<End>", "<PageUp>", "<PageDown>" }) do
    imap(key, "<C-g>u" .. key)
end

-- optional: break before big deletions in insert mode
imap("<C-w>", "<C-g>u<C-w>")
imap("<C-u>", "<C-g>u<C-u>")

vim.o.hidden = true
vim.cmd([[
  cnoreabbrev w  silent w
  cnoreabbrev wa silent wa
]])

vim.lsp.document_color.enable(false)

-- Reload file when there's an edit
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" },
{
    pattern = "*",
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})
