return {
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {"Nash0x7E2/awesome-flutter-snippets"},
    {"rafamadriz/friendly-snippets"},
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    {'momota/cisco.vim'},
    {'alker0/chezmoi.vim'},
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = false,
        branch = 'v3.x',
        keys = {
            { "<A-TAB>", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "LSP - Code Actions" },
            { "<A-TAB>", "<cmd>lua vim.lsp.buf.code_action()<cr>", mode = "v", desc = "LSP - Code Actions" },
       },
    },
}
