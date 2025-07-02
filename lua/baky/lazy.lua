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
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "saghen/blink.cmp",
        version = '1.*',
        dependencies = {
            'Kaiser-Yang/blink-cmp-avante',
        }
    },
    {
        "xzbdmw/colorful-menu.nvim",
        config = function()
            require("blink.cmp").setup({
                keymap = {
                    ['<CR>'] = { 'accept', 'fallback' },
                    ['<S-Tab>'] = {
                        'select_prev',
                        'snippet_backward',
                        'fallback'
                    },
                    ['<Tab>'] = {
                        'select_next',
                        'snippet_forward',
                        'fallback'
                    },
                },
                cmdline = {
                    keymap = { preset = 'inherit' },
                    completion = { menu = { auto_show = true } },
                },
                fuzzy = { implementation = "rust" },
                sources = {
                    -- add lazydev to your completion providers
                    default = { "avante", "lazydev", "lsp", "path", "snippets", "buffer" },
                    providers = {
                        avante = {
                            module = 'blink-cmp-avante',
                            name = 'Avante',
                        },
                        lazydev = {
                            name = "LazyDev",
                            module = "lazydev.integrations.blink",
                            -- make lazydev completions top priority (see `:h blink.cmp`)
                            score_offset = 100,
                        },
                        cmdline = {
                            min_keyword_length = function (ctx)
                                -- when typing a command, only show when the keyword is 3 characters or longer
                                if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 3 end
                                return 0
                            end
                        }
                    },
                },
                completion = {
                    menu = {
                        draw = {
                            -- We don't need label_description now because label and label_description are already
                            -- combined together in label by colorful-menu.nvim.
                            columns = { { "kind_icon" }, { "label", gap = 1 } },
                            components = {
                                label = {
                                    text = function(ctx)
                                        return require("colorful-menu").blink_components_text(ctx)
                                    end,
                                    highlight = function(ctx)
                                        return require("colorful-menu").blink_components_highlight(ctx)
                                    end,
                                },
                            },
                        },
                    },
                },
            })
        end
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
        'stsewd/isort.nvim',
        ft = 'python',
        build = ':UpdateRemotePlugins',
        config = function()
            vim.cmd('autocmd BufWritePre *.py execute ":IsortSync"')
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
        "0x00-ketsu/maximizer.nvim",
    },
    {'echasnovski/mini.nvim', version = false},
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
        },
    },
    {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = true,
    },
    {'wakatime/vim-wakatime', lazy = false},
    {"mfussenegger/nvim-dap"},
    {"mfussenegger/nvim-dap-python"},
    {"tpope/vim-fugitive"},
    --- Uncomment these if you want to manage the language servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'momota/cisco.vim'},
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    { "Nash0x7E2/awesome-flutter-snippets" },
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
    {'rafi/awesome-vim-colorschemes'},

    -- colorschemes
    {"luisiacc/gruvbox-baby"},
    {"tanvirtin/monokai.nvim"},
    {"Tsuzat/NeoSolarized.nvim"},
    {"olimorris/onedarkpro.nvim"},
    {"folke/tokyonight.nvim"},
    {"tiagovla/tokyodark.nvim"},
    {"ray-x/starry.nvim"},
    {"sainnhe/sonokai"},

    {'AndreM222/copilot-lualine'},
    {'mfussenegger/nvim-lint'},
    {'HiPhish/rainbow-delimiters.nvim'},
    {'momota/cisco.vim'},
    {'rrethy/vim-illuminate'},
    {'alker0/chezmoi.vim'},
    {'chrisbra/Colorizer'},
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
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
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
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {}
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            provider = "copilot",
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "stevearc/dressing.nvim", -- for input provider dressing
            "folke/snacks.nvim", -- for input provider snacks
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    }
})
