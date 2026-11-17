return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        keys = {
            { "<leader>c", "<cmd>Copilot panel<cr>", desc = "Copilot - Panel" }
        },
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                -- Keep the existing arrow-key acceptance bindings.
                keymap = {
                    accept = "<M-Right>",
                    accept_word = "<Right>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
                -- Neovim doesn't auto-scroll for virtual lines, so a multi-line
                -- suggestion that extends past the bottom of the window is
                -- invisible. Force-scroll (without moving the cursor) just
                -- enough to fit it.
                suggestion_notification = function(_, virt_lines)
                    local extra_lines = #virt_lines
                    if extra_lines == 0 then
                        return
                    end

                    local win_height = vim.api.nvim_win_get_height(0)
                    local cursor_screen_row = vim.fn.winline()
                    local space_below = win_height - cursor_screen_row

                    if space_below < extra_lines then
                        local view = vim.fn.winsaveview()
                        vim.fn.winrestview({ topline = view.topline + (extra_lines - space_below) + 1 })
                    end
                end,
            },
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
            model = "auto",
            prompts = {
                -- Short git message
                ShortCommit = {
                    prompt = "##git://diff/staged\n\nWrite a one line commit \z
                    message for the staged changes with commitizen convention. \z
                    Format as a gitcommit code block. ",
                    system_prompt = "##git://diff/staged\n\nWrite a one line commit\z
                    message for the staged changes with commitizen convention. \z
                    Format as a gitcommit code block. ",
                }

            }
        },
        -- See Commands section for default commands if you want to lazy load on them
    }
}
