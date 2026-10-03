return {
    "nvim-treesitter/nvim-treesitter",
    -- The main branch is a full rewrite of the plugin: it cannot be lazy-loaded,
    -- has no `nvim-treesitter.configs` module, and compiles parsers with the
    -- tree-sitter CLI (0.26.1+, from a package manager, not npm) and a C compiler.
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        -- Parsers to have installed up front. A no-op for ones already installed.
        ts.install({
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "elixir",
            "heex",
            "javascript",
            "html",
            "python",
            "go",
        })

        local function enable(buf, lang)
            if not vim.api.nvim_buf_is_valid(buf) then
                return
            end
            -- Highlighting is built into Neovim; indentation comes from this plugin.
            if pcall(vim.treesitter.start, buf, lang) then
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end

        -- Replaces the old `highlight`/`indent` options and `auto_install`: start
        -- treesitter for every filetype, installing a missing parser on first use.
        local installing = {}
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("baky_treesitter", { clear = true }),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match) or args.match

                if vim.list_contains(ts.get_installed("parsers"), lang) then
                    enable(args.buf, lang)
                elseif not installing[lang] and vim.list_contains(ts.get_available(), lang) then
                    installing[lang] = true
                    ts.install({ lang }):await(function()
                        installing[lang] = nil
                        vim.schedule(function()
                            enable(args.buf, lang)
                        end)
                    end)
                end
            end,
        })

        -- for hyprlang
        vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
        })
    end,
}
