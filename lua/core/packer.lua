vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use('wbthomason/packer.nvim')

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "catppuccin/nvim", as = "catppuccin" }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('theprimeagen/harpoon')
    use('mason-org/mason.nvim')
    use('mason-org/mason-lspconfig.nvim')
    use('WhoIsSethDaniel/mason-tool-installer.nvim')
    use('neovim/nvim-lspconfig')
    use('hrsh7th/cmp-nvim-lsp-signature-help')
    use({
        "saghen/blink.cmp",
        requires = {
            "rafamadriz/friendly-snippets"
        },
        -- If you prefer to build from source:
        run = "cargo build --release",
        config = function()
            local cmp = require("blink.cmp")
            cmp.setup({
                keymap = {
                    preset = "super-tab",
                    ['<C-j>'] = { 'select_next', 'fallback' },
                    ['<C-k>'] = { 'select_prev', 'fallback' },
                    ['<Esc>'] = { 'hide', 'fallback' }
                },
                appearance = {
                    nerd_font_variant = "mono",
                },
                completion = {
                    trigger = { show_in_snippet = true },
                    documentation = { auto_show = true },
                    menu = { auto_show = true },
                    ghost_text = { enabled = false, show_with_menu = true },
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
                fuzzy = {
                    implementation = "prefer_rust_with_warning",
                },
                signature = { enabled = false },
            })
        end,
    })

    use("hrsh7th/nvim-cmp")

    use {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    }

    use({
        "windwp/nvim-autopairs",
        after = "nvim-cmp", -- ensure it loads after cmp
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({
                check_ts = true,
                enable_check_bracket_line = true,
                ignored_next_char = "[%w%.]",
                map_cr = true,
                map_bs = true,
            })

            -- CMP integration
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    })

    use('ThePrimeagen/vim-be-good');
end)
