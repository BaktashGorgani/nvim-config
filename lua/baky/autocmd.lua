vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ on_macro = true })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("RustFormat", { clear = true }),
    pattern = "*.rs",
    callback = function ()
        vim.lsp.buf.format({ async = false })
    end,
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
    pattern = {"*.hl", "hypr*.conf"},
    callback = function(event)
        print(string.format("starting hyprls for %s", vim.inspect(event)))
        vim.lsp.start {
            name = "hyprlang",
            cmd = {"hyprls"},
            root_dir = vim.fn.getcwd(),
        }
    end,
})
