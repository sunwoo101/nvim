require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    update_cwd = true,
    diagnostics = { enable = true },
    view = {
        width = 50,
        side = "left",
        number = true, -- ← show absolute numbers
        relativenumber = true
    },
    actions = { open_file = { quit_on_open = true } },

    on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        -- restore defaults
        api.config.mappings.default_on_attach(bufnr)

        local function open_tabdrop(node)
            if node.type ~= "file" then
                api.node.open.edit()
                return
            end
            api.tree.close()
            vim.cmd("tab drop " .. vim.fn.fnameescape(node.absolute_path))
        end

        local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

        -- <CR> → tabdrop file OR cd into folder
        vim.keymap.set("n", "<CR>", function()
            local node = api.tree.get_node_under_cursor()
            if not node then return end

            if node.type == "directory" then
                -- cd into the folder
                api.tree.change_root_to_node(node)
            else
                -- open file in tab (reuse existing tab)
                open_tabdrop(node)
            end
        end, vim.tbl_extend("force", opts, { desc = "Open file in tab / cd into folder" }))

        -- o → open file in current window + close tree, or expand/collapse folder
        vim.keymap.set("n", "o", function()
            local node = api.tree.get_node_under_cursor()
            if not node then return end

            if node.type == "directory" then
                -- expand/collapse folder
                api.node.open.edit()
            else
                -- open file in current window + close tree
                api.node.open.edit()
                api.tree.close()
            end
        end, vim.tbl_extend("force", opts, { desc = "Open file / expand folder" }))
    end,
})
