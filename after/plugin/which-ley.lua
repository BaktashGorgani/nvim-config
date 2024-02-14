local wk = require("which-key")

wk.setup({
    triggers_blacklist = {
        i = { "<leader>" },
    },
})

wk.register({
    ["<leader>"] = {
        ["<leader>"] = "Source file",
        a = "Add to Harpoon",
        x = "Make file executable",
        h = "Git hunk",
        g = {
            name = "Git",
            z = "Git zip",
            s = "Git stash",
            b = "Git blame",
        },
        j = {
            name = "Json",
            b = "Beautify",
        },
        p = {
            name = "Project",
            f = "Find files",
            g = "Git files",
            s = "Grep string",
        },
        b = {
            name = "Dap Breakpoints",
            b = "Toggle breakpoint",
            c = "Set breakpoint",
            l = "Log point message",
            r = "Clear breakpoints",
            a = "List breakpoints",
        },
        d = {
            name = "Dap",
            c = "Continue",
            j = "Step over",
            k = "Step into",
            o = "Step out",
            d = "Disconnect",
            t = "Terminate",
            r = "Toggle repl",
            l = "Run last",
            i = "Hover",
            ["?"] = "Scopes",
            f = "Frames",
            h = "Commands",
            e = "Diagnostics",
        },
        t = {
            name = "Dap Test",
            c = "Test class",
            m = "Test method",
        },
        m = {
            name = "Maximizer",
            m = "Maximize",
            r = "Restore",
            t = "Toggle",
        }
    }
})
