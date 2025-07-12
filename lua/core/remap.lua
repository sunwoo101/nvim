vim.g.mapleader = " "

vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)
vim.keymap.set("n", "<leader>v", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>h", vim.cmd.split)

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<C-t>", ":tabnew<CR>", opts)
vim.keymap.set("n", "<C-q>", ":tabclose<CR>", opts)

vim.keymap.set("n", "<C-k>d", function()
  vim.lsp.buf.format()
end, opts)

vim.keymap.set("i", "<C-BS>", "<C-W>", { noremap = true })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { noremap = true })
vim.keymap.set("i", "<C-M-BS>", "<C-o>d0", { noremap = true, silent = true })
vim.keymap.set("i","<C-M-Del>", "<C-o>d$", { noremap = true, silent = true })
