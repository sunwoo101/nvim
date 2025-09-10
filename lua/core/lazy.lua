-- Plugin spec (packer `use()` -> lazy specs)
require("lazy").setup({
    -- Files
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Theme & Treesitter
    { "catppuccin/nvim",                 name = "catppuccin" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Status bar
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}, -- add your lualine options here
    },

    -- LSP
    "neovim/nvim-lspconfig",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "mfussenegger/nvim-jdtls",
    "ray-x/lsp_signature.nvim",
    {
        "seblyng/roslyn.nvim",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {
            filewatching = "auto",
            choose_target = nil,
            ignore_target = nil,
            broad_search = false,
            lock_target = false,
            silent = true,
        }
    },

    -- Snippets / completion
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
    },
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
        build = "cargo build --release",
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    "windwp/nvim-ts-autotag",

    -- Style / UI
    "petertriho/nvim-scrollbar",
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 50,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "      <author>, (<author_time:%d/%m/%Y>)",
        },
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    },
    {
        "utilyre/barbecue.nvim",
        dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("barbecue").setup()
        end,
    },
    "karb94/neoscroll.nvim",
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true,
                    style = { { fg = "#806d9c" }, { fg = "#c21f30" } },
                },
                indent = {
                    enable = true,
                },
            })
        end
    },
    'brenoprata10/nvim-highlight-colors',

    -- Tools
    { 'akinsho/toggleterm.nvim', version = "*", config = true },

    -- Discord RPC
    "andweeb/presence.nvim",
}, {
    -- optional: performance/lazy-load tweaks
    defaults = { lazy = false },
    install = { colorscheme = { "catppuccin" } },
})
