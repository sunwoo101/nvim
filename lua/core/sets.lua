vim.opt.number = true
vim.opt.relativenumber = true

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

-- finer-grained undo like VSCodeh
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
