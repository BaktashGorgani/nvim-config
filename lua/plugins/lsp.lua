return {
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
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
