-- Plugin spec (packer `use()` -> lazy specs)
require("lazy").setup({
    -- Files

    -- Theme & Treesitter
    { "catppuccin/nvim",                 name = "catppuccin" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "yioneko/nvim-yati",

    -- Status bar
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
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
            filewatching = "roslyn",
            choose_target = nil,
            ignore_target = nil,
            broad_search = false,
            lock_target = false,
            silent = true,
        }
    },
    'stevearc/conform.nvim',
    'mfussenegger/nvim-dap',

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
    },

    {
        "wojciech-kulik/xcodebuild.nvim",
        dependencies = {
            --"nvim-telescope/telescope.nvim",
            "folke/snacks.nvim",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("xcodebuild").setup({
                logs = {
                    logs_formatter = nil,
                },
                code_coverage = {
                    enabled = true,
                },
            })
        end,
    },

    -- Snippets / completion
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
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
    "tpope/vim-sleuth",

    -- Style / UI
    "petertriho/nvim-scrollbar",
    "lewis6991/gitsigns.nvim",
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    },
    'Bekaboo/dropbar.nvim',
    'brenoprata10/nvim-highlight-colors',
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    "NStefan002/screenkey.nvim",
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
    },

    -- Tools
    { 'akinsho/toggleterm.nvim', version = "*", config = true },

    -- Discord RPC
    "andweeb/presence.nvim",
}, {
    -- optional: performance/lazy-load tweaks
    defaults = { lazy = false },
    install = { colorscheme = { "catppuccin" } },
})
