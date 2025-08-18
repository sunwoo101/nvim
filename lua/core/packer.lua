vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer
    use("wbthomason/packer.nvim")

    -- File explorer
    use("nvim-tree/nvim-tree.lua")

    -- File search
    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use("theprimeagen/harpoon")

    -- Theme
    use({ "catppuccin/nvim", as = "catppuccin" })
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

    -- Status bar
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
    })

    -- LSP
    use("mason-org/mason.nvim")
    use("mason-org/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use("ray-x/lsp_signature.nvim")
    use("Hoffs/omnisharp-extended-lsp.nvim")
    use({
        "L3MON4D3/LuaSnip",
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })
    use({
        "saghen/blink.cmp",
        requires = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
        run = "cargo build --release",
    })
    use("echasnovski/mini.pairs")

    -- Style
    use("petertriho/nvim-scrollbar")
    use("lewis6991/gitsigns.nvim")

    -- Copilot
    use("github/copilot.vim")

    -- Discord RPC
    use('andweeb/presence.nvim')
end)
