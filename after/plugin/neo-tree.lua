require("neo-tree").setup({
    enable_diagnostics = true,
    close_if_last_window = false,

    filesystem = {
        follow_current_file = { enabled = false },
        use_libuv_file_watcher = true,
        filtered_items = {
            visible = true, -- show hidden files
            hide_dotfiles = false,
            hide_gitignored = false,
        },

        window = {
            use_default_mappings = false,
            mapping_options = { noremap = true, nowait = true, silent = true },
            mappings = {
                -- <CR> → expand/collapse dir OR open file and CLOSE tree
                ["<CR>"] = function(state)
                    local node = state.tree:get_node()
                    if not node then return end
                    if node.type == "directory" then
                        state.commands.toggle_node(state)
                    else
                        -- open in current window and close the tree
                        state.commands.open(state, { close_tree = true })
                    end
                end,

                -- o → same behavior as above (or tweak if you want)
                ["o"] = function(state)
                    local node = state.tree:get_node()
                    if not node then return end
                    if node.type == "directory" then
                        state.commands.toggle_node(state)
                    else
                        state.commands.open(state, { close_tree = true })
                    end
                end,

                -- re-add any other actions you want
                ["q"] = "close_window",
                ["R"] = "refresh",
                ["a"] = { "add", config = { show_path = "relative" } },
                ["d"] = "delete",
                ["r"] = "rename",
            },
        },
    },

    window = {
        position = "left",
        width = 40,
    },

    -- numbers in the tree (optional)
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function()
                vim.api.nvim_set_option_value("number", true, { scope = "local" })
                vim.api.nvim_set_option_value("relativenumber", true, { scope = "local" })
            end,
        },
    },
})

-- Close any neo-tree windows when entering a normal buffer
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.bo.filetype == "neo-tree" then return end
        -- Close only if a neo-tree window is actually open in this tab
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == "neo-tree" then
                pcall(vim.cmd, "Neotree close")
                break
            end
        end
    end,
})
