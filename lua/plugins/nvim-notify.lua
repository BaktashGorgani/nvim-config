return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")

        notify.setup({
            background_colour = "normal",
            render = "compact",
            -- default timeout for notifications
            timeout = 2500,
            merge_duplicates = true,
        })

        vim.keymap.set("n", "<esc>", function()
            notify.dismiss()
        end, { desc = "dismiss notify popup" })
    end
}
