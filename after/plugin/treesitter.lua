local treesitter = require("nvim-treesitter")
local parsers = require("nvim-treesitter.parsers")

local ensure_installed = {
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
}

local pending = {}

local function track_install(languages)
    local task = treesitter.install(languages)
    for _, lang in ipairs(languages) do
        pending[lang] = task
    end
    task:await(vim.schedule_wrap(function(err, success)
        for _, lang in ipairs(languages) do
            if pending[lang] == task then
                pending[lang] = nil
            end
            if not err and success ~= false then
                for _, query in ipairs({ "highlights", "injections", "indents", "folds", "locals" }) do
                    vim.treesitter.query.get:clear(lang, query)
                end
            end
        end
        if err or success == false then
            vim.notify(
                "Treesitter installation failed for " .. table.concat(languages, ", ")
                    .. (err and (": " .. tostring(err)) or "; see :messages"),
                vim.log.levels.WARN
            )
        end
    end))
    return task
end

local function enable(buf, lang)
    if not vim.api.nvim_buf_is_valid(buf)
        or vim.treesitter.language.get_lang(vim.bo[buf].filetype) ~= lang then
        return false
    end

    local ok = pcall(vim.treesitter.start, buf, lang)
    if ok then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
    return ok
end

track_install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TreesitterAutoInstall", { clear = true }),
    callback = function(args)
        local buf = args.buf
        if vim.bo[buf].buftype ~= "" then
            return
        end

        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
            return
        end

        local enabled = enable(buf, lang)
        -- Old parser binaries can still load without their highlight queries.
        -- Install these into the current layout as well.
        if enabled and vim.list_contains(treesitter.get_installed("parsers"), lang) then
            return
        end
        if not parsers[lang] or parsers[lang].tier == 4 then
            return
        end

        local task = pending[lang] or track_install({ lang })
        task:await(vim.schedule_wrap(function(err, success)
            if not err and success ~= false then
                enable(buf, lang)
            end
        end))
    end,
})

vim.filetype.add({
    pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
