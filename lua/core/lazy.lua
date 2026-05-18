-- Plugin spec (packer `use()` -> lazy specs)
require("lazy").setup({
    -- Theme & Treesitter
    { "catppuccin/nvim",                 name = "catppuccin" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", branch = "main" },

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
            extensions = {
                razor = {
                    enabled = true,
                    config = function()
                        local razor_path = require("roslyn.utils").find_razor_extension_path()
                        if razor_path == nil then
                            return { path = nil }
                        end
                        -- args removed: 5.8.0+ no longer accepts --razorSourceGenerator / --razorDesignTimePath
                        return {
                            path = vim.fs.joinpath(razor_path, "Microsoft.VisualStudioCode.RazorExtension.dll"),
                        }
                    end,
                },
            },
        }
    },
    'stevearc/conform.nvim',
    'mfussenegger/nvim-dap',
    'github/copilot.vim',

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
        dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip", "saghen/blink.lib" },
        build = "cargo build --release",
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    "windwp/nvim-ts-autotag",
    "tpope/vim-sleuth",

    -- Bracket colourizer
    "HiPhish/rainbow-delimiters.nvim",
    "sunwoo101/hlchunk.nvim",

    -- Style / UI
    { "lewis6991/satellite.nvim", opts = {} },
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
    { 'akinsho/toggleterm.nvim',  version = "*", config = true },

    -- Discord RPC
    "andweeb/presence.nvim",
}, {
    -- optional: performance/lazy-load tweaks
    defaults = { lazy = false },
    install = { colorscheme = { "catppuccin" } },
})
