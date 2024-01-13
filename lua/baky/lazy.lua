local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                              , branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			require("telescope").setup({})
			require("telescope").load_extension("undo")
		end,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{"theprimeagen/harpoon"},
	{"tpope/vim-fugitive"},
	--- Uncomment these if you want to manage the language servers from neovim
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},

	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
	{'airblade/vim-gitgutter'},
	{'dense-analysis/ale'},
	{'jeetsukumaran/vim-pythonsense'},
	{'michaeljsmith/vim-indent-object'},
	{'ms-jpq/chadtree', branch = 'chad', build = 'python3 -m chadtree deps'},
	{'psf/black', branch = 'stable'},
	{'kkoomen/vim-doge', build = ':call doge#install()'},
	{'andweeb/presence.nvim'},
	{'tiagofumo/vim-nerdtree-syntax-highlight'},
	{'ryanoasis/vim-devicons'},
	{'nvim-tree/nvim-web-devicons'},
	{'adelarsq/vim-devicons-emoji'},
})