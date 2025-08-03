return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local wk = require("which-key")

        wk.setup({
            ---@param ctx { mode: string,  operator: string }
            defer = function(ctx)
                if vim.list_contains({ "<leader" }, ctx.operator) then
                    return true
                end
                return vim.list_contains({ "<C-V>", "V" }, ctx.mode)
            end
        })

        wk.add({
            {
                { "<leader><leader>", desc = "Source file" },
                { "<leader>a", desc = "Add to Harpoon" },
                { "<leader>b", group = "Dap Breakpoints" },
                { "<leader>d", group = "Dap" },
                { "<leader>g", group = "Git" },
                { "<leader>h", desc = "Git hunk" },
                { "<leader>j", group = "Json" },
                { "<leader>jb", desc = "Beautify" },
                { "<leader>m", group = "Maximizer" },
                { "<leader>p", group = "Project" },
                { "<leader>t", group = "Dap Test" },
                { "<leader>tc", desc = "Test class" },
                { "<leader>tm", desc = "Test method" },
                { "<leader>x", desc = "Make file executable" },
            }
        })
    end
}
