-- remove your custom tabline
vim.o.showtabline = 2

-- jump to buffer 1..9 with <leader>1..9 (NvChad-style)
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        vim.cmd("BufferLineGoToBuffer " .. i)
    end, { silent = true, desc = "Go to buffer " .. i })
end
