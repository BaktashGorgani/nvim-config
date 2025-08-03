return {
    -- https://github.com/f-person/git-blame.nvim
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    keys = {
        { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Git Blame - Toggle"}
    },
    opts = {
        date_format = '%m/%d/%y %H:%M:%S', -- more concise date format
    }
}
