return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Dap - Toggle breakpoint" },
            { "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", desc = "Dap - Set breakpoint" },
            { "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", desc = "Dap - Log point message" },
            { '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", desc = "Dap - Clear breakpoints" },
            { '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', desc = "Dap - List breakpoints" },
            { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Dap - Continue" },
            { "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", desc = "Dap - Step Over" },
            { "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", desc = "Dap - Step Into" },
            { "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", desc = "Dap - Step Out" },
            { '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end, desc = "Dap - Disconnect" },
            { '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end, desc = "Dap - Terminate" },
            { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Dap - Toggle Repl" },
            { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Dap - Run Last" },
            { '<leader>di', function() require "dap.ui.widgets".hover() end, desc = "Dap - Hover" },
            { '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end, desc = "Dap - Scopes" },
            { '<leader>df', '<cmd>Telescope dap frames<cr>', desc = "Dap - Frames" },
            { '<leader>dh', '<cmd>Telescope dap commands<cr>', desc = "Dap - Commands" },
            { '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end, desc = "Dap - Diagnostics" },
        },
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

            vim.keymap.set("n", '<leader>tc', function()
                if vim.bo.filetype == 'python' then
                    require('dap-python').test_class();
                end
            end)

            vim.keymap.set("n", '<leader>tm', function()
                if vim.bo.filetype == 'python' then
                    require('dap-python').test_method();
                end
            end)
        end
    },
    {
        -- https://github.com/theHamsta/nvim-dap-virtual-text
        'theHamsta/nvim-dap-virtual-text',
        lazy = true,
        opts = {
            -- Display debug text as a comment
            commented = true,
            -- Customize virtual text
            ---@diagnostic disable-next-line: unused-local
            display_callback = function(variable, buf, stackframe, node, options)
                if options.virt_text_pos == 'inline' then
                    return ' = ' .. variable.value
                else
                    return variable.name .. ' = ' .. variable.value
                end
            end,
        }
    },
    {
        -- https://github.com/rcarriga/nvim-dap-ui
        'rcarriga/nvim-dap-ui',
        event = 'VeryLazy',
        dependencies = {
            -- https://github.com/mfussenegger/nvim-dap
            'mfussenegger/nvim-dap',
            -- https://github.com/theHamsta/nvim-dap-virtual-text
            'theHamsta/nvim-dap-virtual-text', -- inline variable text while debugging
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local opts = {
                layouts = {
                    {
                        elements = {
                            {
                                id = "scopes",
                                size = 0.35
                            },
                            {
                                id = "watches",
                                size = 0.35
                            },
                            {
                                id = "stacks",
                                size = 0.15
                            },
                            {
                                id = "breakpoints",
                                size = 0.15
                            }
                        },
                        size = 65,
                        position = "left", -- Can be "left" or "right"
                    },
                    {
                        elements = {
                            "console",
                        },
                        size = 14,
                        position = "bottom", -- Can be "bottom" or "top"
                    },
                    {
                        elements = {
                            "repl",
                        },
                        size = 14,
                        position = "bottom", -- Can be "bottom" or "top"
                    },
                },
            }

            local dap, dapui = require("dap"), require("dapui")
            dapui.setup(opts)
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
        end
    },
}
