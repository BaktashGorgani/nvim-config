return {
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
                default = { "copilot", "avante", "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
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
}
