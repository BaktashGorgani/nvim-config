return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    keys = {
        { "<leader>pc", "<cmd>FzfLua builtin<cr>", {}, desc = "FZF - " },
        { "<leader>pf", "<cmd>FzfLua files<cr>", {}, desc = "FZF - Files" },
        { "<leader>pr", "<cmd>FzfLua oldfiles<cr>", {}, desc = "FZF - Recent" },
        { "<leader>pg", "<cmd>FzfLua git_files<cr>", {}, desc = "FZF - Git Files" },
        { "<leader>ps", "<cmd>FzfLua live_grep<cr>", {}, desc = "FZF - Live Grep" },
        { "<leader>pb", "<cmd>FzfLua buffers<cr>", {}, desc = "FZF - Buffers" },
    },
    config = function()
        require('fzf-lua').register_ui_select()
    end
}
