vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle<CR>", opts)
vim.keymap.set("n", "<leader>h", "<Cmd>leftabove vsplit<Bar>wincmd h<CR>", opts)
vim.keymap.set("n", "<leader>l", "<Cmd>rightbelow vsplit<Bar>wincmd l<CR>", opts)

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<leader>t", "<cmd>enew<CR>", opts)
vim.keymap.set("n", "<leader>w", "<cmd>bdelete<CR>", opts)
vim.keymap.set("n", "<leader><Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<leader><S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)

vim.keymap.set("i", "<C-BS>", "<C-W>", { noremap = true })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { noremap = true })
vim.keymap.set("i", "<C-M-BS>", "<C-o>d0", opts)
vim.keymap.set("i", "<C-M-Del>", "<C-o>d$", opts)

local function exit_snippet_or_esc()
    local ok, ls = pcall(require, "luasnip")
    if ok and ls.session.current_nodes[vim.api.nvim_get_current_buf()] then
        ls.unlink_current()
    end
    return "<Esc>"
end

vim.keymap.set({ "i", "s" }, "jk", exit_snippet_or_esc, { expr = true, silent = true })
vim.keymap.set({ "i", "s" }, "kj", exit_snippet_or_esc, { expr = true, silent = true })
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.keymap.set('t', 'kj', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic floag" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol" })

vim.keymap.set("v", "<leader>y", '"+y<Esc>', opts)

--vim.keymap.set("n", "<F12>", "<cmd>lua require('omnisharp_extended').telescope_lsp_definition()<CR>", opts)
--vim.keymap.set("n", "<C-]>", "<cmd>lua require('omnisharp_extended').telescope_lsp_definition()<CR>", opts)

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set("n", "<Tab>", "<Nop>")
vim.keymap.set("n", "<C-i>", "<Nop>")
