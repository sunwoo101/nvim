vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
		'olivercederborg/poimandres.nvim',
		config = function()
			require('poimandres').setup {
			}
		end
	}

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('theprimeagen/harpoon')
	use('mason-org/mason.nvim')
	use('neovim/nvim-lspconfig')
	use({
		"saghen/blink.cmp",
		requires = {
			"rafamadriz/friendly-snippets",
			"Saghen/frizbee"
		},
		-- If you prefer to build from source:
		-- run = "cargo build --release",
		config = function()
			require("blink.cmp").setup({
				keymap = { preset = "super-tab" },
				appearance = {
					nerd_font_variant = "mono",
				},
				completion = {
					documentation = { auto_show = true },
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				fuzzy = {
					implementation = "prefer_rust_with_warning",
				},
			})
		end,
	})

end)
