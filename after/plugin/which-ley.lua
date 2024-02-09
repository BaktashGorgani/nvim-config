local wk = require("which-key")

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
    }
})
