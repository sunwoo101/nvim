local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope find keywords ' })

--This configuration sets up Telescope with custom key mappings for opening files in a new tab.
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<CR>"] = function(prompt_bufnr)
                    local entry = action_state.get_selected_entry()
                    local path = entry.path or entry.filename
                    actions.close(prompt_bufnr)
                    vim.cmd("edit " .. vim.fn.fnameescape(path))
                end,
            },
            n = {
                ["<CR>"] = function(prompt_bufnr)
                    local entry = action_state.get_selected_entry()
                    local path = entry.path or entry.filename
                    actions.close(prompt_bufnr)
                    vim.cmd("edit " .. vim.fn.fnameescape(path))
                end,
            },
        },
    },
})
