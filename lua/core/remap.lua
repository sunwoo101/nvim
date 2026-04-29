vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
--vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle reveal<CR>", opts)
-- Replace your leader fe mapping
--vim.keymap.set("n", "<leader>fe", function() Snacks.explorer() end, { desc = "Snacks Explorer" })
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle reveal<CR>", opts)
vim.keymap.set("n", "<leader>h", "<Cmd>leftabove vsplit<Bar>wincmd h<CR>", opts)
vim.keymap.set("n", "<leader>l", "<Cmd>rightbelow vsplit<Bar>wincmd l<CR>", opts)

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set({ "n", "v" }, "<C-j>", "<C-d>", opts)
vim.keymap.set({ "n", "v" }, "<C-k>", "<C-u>", opts)

vim.keymap.set("n", "<leader>w", "<cmd>bdelete<CR>", opts)
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)

vim.keymap.set("n", "<leader>o", "<C-o>", { desc = "Jump Backward", noremap = true, silent = true })
vim.keymap.set("n", "<leader>i", "<C-i>", { desc = "Jump Forward", noremap = true, silent = true })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definition" })

vim.keymap.set("i", "<C-BS>", "<C-W>", { noremap = true })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { noremap = true })
vim.keymap.set("i", "<C-M-BS>", "<C-o>d0", opts)
vim.keymap.set("i", "<C-M-Del>", "<C-o>d$", opts)

local function smart_esc()
    local blink = require("blink.cmp")
    local ok, ls = pcall(require, "luasnip")

    if ok and ls.session and ls.session.current_nodes[vim.api.nvim_get_current_buf()] then
        if blink.is_visible() then
            vim.schedule(function()
                blink.hide()
            end)

            return "<Ignore>"
        end

        ls.unlink_current()
    end

    return "<Esc>"
end

vim.keymap.set({ "i", "s" }, "jk", smart_esc, { expr = true, silent = true })
vim.keymap.set({ "i", "s" }, "kj", smart_esc, { expr = true, silent = true })
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.keymap.set('t', 'kj', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic floag" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol" })

vim.keymap.set("v", "<leader>y", '"+y<Esc>', opts)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP Code Action" })
