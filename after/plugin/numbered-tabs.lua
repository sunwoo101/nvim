-- remove your custom tabline
vim.o.showtabline = 2

--[[
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        vim.cmd("BufferLineGoToBuffer " .. i)
    end, { silent = true, desc = "Go to buffer " .. i })
end
]]

for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        require("bufferline").go_to(i, true) -- uses ordinal
    end, { desc = "Go to buffer " .. i })
end
