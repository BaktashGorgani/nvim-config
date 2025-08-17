return {
    { 'neovim/nvim-lspconfig', lazy = false, priority = 1000 },
    { 'williamboman/mason.nvim', lazy = false, priority = 1000 },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        priority = 1000,
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
        config = function()
            -- Run LSP setup only after mason-lspconfig is available to avoid duplicate clients
            require('baky.lsp')
        end,
    },
    { "Nash0x7E2/awesome-flutter-snippets" },
    { "rafamadriz/friendly-snippets" },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    { 'momota/cisco.vim' },
    { 'alker0/chezmoi.vim' },
}
