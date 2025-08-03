return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gs", vim.cmd.Git, desc = "Git - Status" },
        { "<leader>gf", "<cmd>Git pull<cr>", desc = "Git - Pull (Fetch & Merge)" },
        { "<leader>gp", "<cmd>Git push<cr>", desc = "Git - Push" },
        { "<leader>gl", "<cmd>Git log<cr>", desc = "Git - Log" },
        { "<leader>gst", "<cmd>Git stash<cr>", desc = "Git - Stash" },
        { "<leader>gsp", "<cmd>Git stash pop<cr>", desc = "Git - Stash Pop" },
        { "<leader>gz", "<cmd>Git archive --format zip --output git.zip main<cr>", desc = "Git - Zip" },
        { "<leader>ga", "<cmd>Git add %<cr>", desc = "Git - Add" },
    },
}
