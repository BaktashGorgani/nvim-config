return {
    "0x00-ketsu/maximizer.nvim",
    keys = {
        {
            "<leader>mt",
            '<cmd>lua require("maximizer").toggle()<CR>',
            desc = "Maximizer - Toggle",
            silent = true,
            noremap = true
        },
        {
            "<leader>mm",
            '<cmd>lua require("maximizer").maximize()<CR>',
            desc = "Maximizer - Maximize",
            silent = true,
            noremap = true,
        },
        {
            "<leader>mr",
            '<cmd>lua require("maximizer").restore()<CR>',
            desc = "Maximizer - Restore",
            silent = true,
            noremap = true,
        },
    },
}
