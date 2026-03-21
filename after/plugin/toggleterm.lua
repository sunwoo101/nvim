require("toggleterm").setup({
    direction = "float",
    persist_mode = false,
    float_opts = {
        border = "rounded",
        width = function() return math.floor(vim.o.columns * 0.9) end,
        height = function() return math.floor(vim.o.lines * 0.9) end,
    },
    open_mapping = nil,
})

--[[
local function toggle_float_term()
    require("toggleterm").toggle(1, nil, nil, "float")
    vim.wo.number = true
    vim.wo.relativenumber = true
end

vim.keymap.set({ "n", "t" }, "<C-CR>", toggle_float_term, { silent = true, desc = "Toggle float terminal" })
]]

local function get_process_name(bufnr)
    local channel = vim.b[bufnr].terminal_job_id
    if not channel then return "New" end

    local pid = vim.fn.jobpid(channel)
    local process = ""

    -- 1. Try to get the child process name (Cross-platform approach)
    -- We use a simple ps command that works on both BSD (Mac) and GNU (Linux)
    local handle = io.popen(string.format("ps -o comm= -p $(pgrep -P %d | tail -n 1) 2>/dev/null", pid))
    if handle then
        process = handle:read("*a"):gsub("%s+", "")
        handle:close()
    end

    -- 2. If the process is just the shell, or empty, get the directory
    if process == "" or process:match("zsh") or process:match("bash") or process:match("sh") then
        local term_title = vim.b[bufnr].term_title or ""

        -- Clean up the title to get the directory
        -- This handles "user@host: dir" (Linux) and "zsh: dir" (Mac)
        local dir = term_title:gsub("^%w+@[^:]+: ", "") -- Strips user@host:
        dir = dir:gsub("^%w+: ", "")                    -- Strips shell:
        dir = dir:gsub(" .*", "")                       -- Strips trailing info

        return (dir ~= "") and dir or "zsh"
    end

    return process
end

local function toggle_hub()
    local terminal = require("toggleterm.terminal")
    local terminals = terminal.get_all()

    for _, term in ipairs(terminals) do
        if term:is_open() then
            term:close()
            return
        end
    end

    local items = {}
    for i = 1, 4 do
        local term = terminal.get(i)
        local title = "New"
        if term and term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
            title = term.display_name or get_process_name(term.bufnr)
        end
        table.insert(items, { text = string.format("%s", title), idx = i })
    end

    require("snacks").picker({
        source = "terminal_hub",
        items = items,
        -- finder is required to populate the list in recent Snacks versions
        finder = function() return items end,
        format = function(item, _)
            return {
                { tostring(item.idx) .. ". ", "SnacksPickerIdx" }, -- The number with a highlight group
                { item.text,                  "SnacksPickerText" }, -- The title
            }
        end,
        layout = {
            preset = "default",
            preview = false,
            -- Override the preset to center it
            layout = {
                backdrop = false,
                row = 0.4,
                width = 60,
                height = 4,
                box = "vertical",
                border = "rounded",
                title = " Terminal Hub",
                title_pos = "center",
                { win = "list", border = "none" },
            }
        },
        win = {
            list = {
                keys = {
                    ["1"] = function(p)
                        p:close(); require("toggleterm").toggle(1, nil, nil, "float")
                    end,
                    ["2"] = function(p)
                        p:close(); require("toggleterm").toggle(2, nil, nil, "float")
                    end,
                    ["3"] = function(p)
                        p:close(); require("toggleterm").toggle(3, nil, nil, "float")
                    end,
                    ["4"] = function(p)
                        p:close(); require("toggleterm").toggle(4, nil, nil, "float")
                    end,
                },
            },
        },
        confirm = function(picker, item)
            picker:close()
            if item then
                require("toggleterm").toggle(item.idx, nil, nil, "float")
            end
        end,
    })
end

-- Map it to your Ctrl+Enter
vim.keymap.set({ "n", "t", "i" }, "<C-CR>", toggle_hub, { silent = true, desc = "Terminal Hub" })
