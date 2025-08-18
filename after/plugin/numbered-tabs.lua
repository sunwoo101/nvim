-- Custom tabline: [n] *filename  (with * for unsaved buffers)
vim.o.showtabline = 2 -- always show tabline

function _G.my_tabline()
    local s = ""
    local tab_count = vim.fn.tabpagenr("$")

    for i = 1, tab_count do
        -- Highlight active tab
        if i == vim.fn.tabpagenr() then
            s = s .. "%#TabLineSel#"
        else
            s = s .. "%#TabLine#"
        end

        -- Clickable tab number
        s = s .. "%" .. i .. "T"

        -- Tab number [n]
        s = s .. "[" .. i .. "] "

        -- Get buffer name for this tab
        local win = vim.fn.tabpagewinnr(i)
        local buflist = vim.fn.tabpagebuflist(i)
        local bufnr = buflist[win]
        local name = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")

        if name == "" then
            name = "[No Name]"
        end

        -- Add * if buffer is modified
        if vim.bo[bufnr].modified then
            name = name .. " ●"
        end

        s = s .. name .. " "
    end

    s = s .. "%#TabLineFill#"
    return s
end

vim.o.tabline = "%!v:lua.my_tabline()"

-- Tab jump mappings: <leader>1 .. <leader>9
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        if i <= vim.fn.tabpagenr("$") then
            vim.cmd(i .. "tabnext")
        end
    end, { noremap = true, silent = true, desc = "Go to tab " .. i })
end
