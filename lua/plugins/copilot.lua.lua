return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        keys = {
            { "<leader>c", "<cmd>Copilot panel<cr>", desc = "Copilot - Panel" }
        },
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    {'AndreM222/copilot-lualine'},
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        keys = {
            { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Copilot - Explain" },
            { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "Copilot - Review" },
            { "<leader>ccf", "<cmd>CopilotChatFix<cr>", desc = "Copilot - Fix" },
            { "<leader>cco", "<cmd>CopilotChatOptimize<cr>", desc = "Copilot - Optimize" },
            { "<leader>ccd", "<cmd>CopilotChatDocs<cr>", desc = "Copilot - Docs" },
            { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Copilot - Tests" },
            { "<leader>ccm", "<cmd>CopilotChatCommit<cr>", desc = "Copilot - Commit" },
            { "<leader>ccn", "<cmd>CopilotChatShortCommit<cr>", desc = "Copilot - Short Commit" },
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
            prompts = {
                -- Short git message
                ShortCommit = {
                    prompt = "#git:`staged`:Write a one line commit \z
                    message for the staged changes with commitizen convention. \z
                    Format as a gitcommit code block. ",
                    system_prompt = "#git:`staged`:Write a one line commit \z
                    message for the staged changes with commitizen convention. \z
                    Format as a gitcommit code block. ",
                }

            }
        },
        -- See Commands section for default commands if you want to lazy load on them
    }
}
