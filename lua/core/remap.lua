vim.g.mapleader = " "

vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)
vim.keymap.set("n", "<leader>v", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>h", vim.cmd.split)
vim.keymap.set("n", "<leader>l", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>j", vim.cmd.split)

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
vim.keymap.set("n", "<C-k><C-d>", function()
    vim.lsp.buf.format()
end, opts)

vim.keymap.set("i", "<C-BS>", "<C-W>", { noremap = true })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { noremap = true })
vim.keymap.set("i", "<C-M-BS>", "<C-o>d0", opts)
vim.keymap.set("i", "<C-M-Del>", "<C-o>d$", opts)

vim.keymap.set("i", "jk", "<Esc>", { noremap = false })
vim.keymap.set("i", "kj", "<Esc>", { noremap = false })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic floag" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol" })

vim.keymap.set("v", "<leader>y", '"+y<Esc>', opts)

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "i:*",
    callback = function()
        vim.schedule(function()
            if vim.snippet and vim.snippet.active() then
                vim.snippet.stop()
            end
        end)
    end,
    desc = "Exit snippet mode on leaving insert mode",
})
