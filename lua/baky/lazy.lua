local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

local function get_git_diff(staged)
    local cmd = staged and "git diff --staged" or "git diff"
    local handle = io.popen(cmd)
    if not handle then
        return ""
    end

    local result = handle:read("*a")
    handle:close()
    return result
end

local prompts = {
    -- Code related prompts
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    FixCode = "Please fix the following code to make it work as intended.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
    -- Text related prompts
    Summarize = "Please summarize the following text.",
    Spelling = "Please correct any grammar and spelling errors in the following text.",
    Wording = "Please improve the grammar and wording of the following text.",
    Concise = "Please rewrite the following text to make it more concise.",
}

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            require("telescope").setup({})
            require("telescope").load_extension("undo")
            require("telescope").load_extension("aerial")
        end,
    },
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'stevearc/aerial.nvim',
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
    },
    {
        'fisadev/vim-isort',
        ft = 'python',
        config =function ()
            vim.cmd('autocmd BufWritePre *.py execute ":Isort"')
        end
    },
    {
        'psf/black',
        branch = 'stable',
        ft = 'python',
        config =function ()
            vim.cmd('autocmd BufWritePre *.py execute ":Black"')
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {"mfussenegger/nvim-dap"},
    {"mfussenegger/nvim-dap-python"},
    {"tpope/vim-fugitive"},
    --- Uncomment these if you want to manage the language servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'saadparwaiz1/cmp_luasnip'},
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    { "rafamadriz/friendly-snippets" },
    {'airblade/vim-gitgutter'},
    {'jeetsukumaran/vim-pythonsense'},
    {'michaeljsmith/vim-indent-object'},
    {'kkoomen/vim-doge', build = ':call doge#install()'},
    {'andweeb/presence.nvim'},
    {'tiagofumo/vim-nerdtree-syntax-highlight'},
    {'ryanoasis/vim-devicons'},
    {'nvim-tree/nvim-web-devicons'},
    {'adelarsq/vim-devicons-emoji'},
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
    {'rafi/awesome-vim-colorschemes'},
    {'AndreM222/copilot-lualine'},
    {'mfussenegger/nvim-lint'},
    {'HiPhish/rainbow-delimiters.nvim'},
    {
        -- https://github.com/f-person/git-blame.nvim
        'f-person/git-blame.nvim',
        event = 'VeryLazy',
        opts = {
            date_format = '%m/%d/%y %H:%M:%S', -- more concise date format
        }
    },
    {
        -- https://github.com/theHamsta/nvim-dap-virtual-text
        'theHamsta/nvim-dap-virtual-text',
        lazy = true,
        opts = {
            -- Display debug text as a comment
            commented = true,
            -- Customize virtual text
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
            -- https://github.com/nvim-telescope/telescope-dap.nvim
            'nvim-telescope/telescope-dap.nvim', -- telescope integration with dap
        },
        opts = {
            controls = {
                element = "repl",
                enabled = false,
                icons = {
                    disconnect = "",
                    pause = "",
                    play = "",
                    run_last = "",
                    step_back = "",
                    step_into = "",
                    step_out = "",
                    step_over = "",
                    terminate = ""
                }
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" }
                }
            },
            force_buffers = true,
            icons = {
                collapsed = "",
                current_frame = "",
                expanded = ""
            },
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.50
                        },
                        {
                            id = "stacks",
                            size = 0.30
                        },
                        {
                            id = "watches",
                            size = 0.10
                        },
                        {
                            id = "breakpoints",
                            size = 0.10
                        }
                    },
                    size = 40,
                    position = "left", -- Can be "left" or "right"
                },
                {
                    elements = {
                        "repl",
                        "console",
                    },
                    size = 10,
                    position = "bottom", -- Can be "bottom" or "top"
                }
            },
            mappings = {
                edit = "e",
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t"
            },
            render = {
                indent = 1,
                max_value_lines = 100
            }
        },
        config = function (_, opts)
            local dap = require('dap')
            require('dapui').setup(opts)

            dap.listeners.after.event_initialized["dapui_config"] = function()
                require('dapui').open()
            end

            dap.listeners.before.event_terminated["dapui_config"] = function()
                -- Commented to prevent DAP UI from closing when unit tests finish
                -- require('dapui').close()
            end

            dap.listeners.before.event_exited["dapui_config"] = function()
                -- Commented to prevent DAP UI from closing when unit tests finish
                -- require('dapui').close()
            end

            -- Add dap configurations based on your language/adapter settings
            -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
            -- dap.configurations.xxxxxxxxxx = {
            --   {
            --   },
            -- }
        end
    },
    {
        "jellydn/CopilotChat.nvim",
        opts = {
            mode = "split",
            prompts = prompts,
        },
        build = function()
            vim.defer_fn(function()
                vim.cmd("UpdateRemotePlugins")
                vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
            end, 3000)
        end,
        event = "VeryLazy",
        keys = {
            -- Code related commands
            { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
            { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
            { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
            { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
            { "<leader>ccf", "<cmd>CopilotChatFixCode<cr>", desc = "CopilotChat - Fix code" },
            { "<leader>ccb", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Name" },
            { "<leader>ccd", "<cmd>CopilotChatDocumentation<cr>", desc = "CopilotChat - Add documentation for code" },
            -- Text related commands
            { "<leader>ccs", "<cmd>CopilotChatSummarize<cr>", desc = "CopilotChat - Summarize text" },
            { "<leader>ccS", "<cmd>CopilotChatSpelling<cr>", desc = "CopilotChat - Correct spelling" },
            { "<leader>ccw", "<cmd>CopilotChatWording<cr>", desc = "CopilotChat - Improve wording" },
            { "<leader>ccc", "<cmd>CopilotChatConcise<cr>", desc = "CopilotChat - Make text concise" },
            -- Chat with Copilot in visual mode
            {
                "<leader>ccv",
                ":CopilotChatVisual",
                mode = "x",
                desc = "CopilotChat - Open in vertical split",
            },
            {
                "<leader>ccx",
                ":CopilotChatInPlace<cr>",
                mode = "x",
                desc = "CopilotChat - Run in-place code",
            },
            -- Custom input for CopilotChat
            {
                "<leader>cci",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
                desc = "CopilotChat - Ask input",
            },
            -- Generate commit message base on the git diff
            {
                "<leader>ccm",
                function()
                    local diff = get_git_diff()
                    if diff ~= "" then
                        vim.fn.setreg('"', diff)
                        vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
                    end
                end,
                desc = "CopilotChat - Generate commit message for all changes",
            },
            {
                "<leader>ccM",
                function()
                    local diff = get_git_diff(true)
                    if diff ~= "" then
                        vim.fn.setreg('"', diff)
                        vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
                    end
                end,
                desc = "CopilotChat - Generate commit message for staged changes",
            },
            -- Debug
            { "<leader>ccD", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
        },
    },
})
