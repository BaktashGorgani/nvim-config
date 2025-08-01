vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require('gitblame')

local background
local foreground

local colorscheme = vim.api.nvim_get_hl(0,{
    name = "Normal"
})

local neotreeColors = vim.api.nvim_get_hl(0,{
    name = "NeoTreeNormal"
})

if colorscheme["bg"] then
    background = string.format("#%x", colorscheme["bg"])
else
    background = "#0"
end

if not neotreeColors["bg"] or neotreeColors["bg"] == colorscheme["bg"] then
    if background == "#0" or background == "#11121d" or background == "#26292c" then
        foreground = "#2C2C2C"
    else
        foreground = "#0"
    end
else
    foreground = string.format("#%x", neotreeColors["bg"])
end

local colors = {
    background = background,
    foreground = foreground,
    red = '#cdd6f4',
    grey = '#181825',
    black = '#1e1e2e',
    white = '#313244',
    light_green = '#6c7086',
    orange = '#fab387',
    green = '#a6e3a1',
    blue = '#80A7EA',
}

local theme = {
    normal = {
        a = { fg = colors.black, bg = colors.blue },
        b = { fg = colors.blue, bg = colors.white },
        c = { fg = colors.white, bg = colors.background },
    },
    insert = { a = { fg = colors.black, bg = "red" } },
    visual = { a = { fg = colors.black, bg = "magenta" } },
    replace = { a = { fg = colors.black, bg = colors.green } },
}

local vim_icons = {
    function()
        return " "
    end,
    separator = { left = "", right = "" },
    color = { bg = colors.foreground, fg = "#80A7EA" },
}

local space = {
    function()
        return " "
    end,
    color = { bg = colors.background },
}

local filename = {
    'filename',
    color = { bg = "#b4befe", fg = "#242735" },
    separator = { left = "", right = "" },
}

local filetype = {
    "filetype",
    icon_only = true,
    colored = true,
    color = { bg = colors.foreground },
    separator = { left = "", right = "" },
}

local fileformat = {
    'fileformat',
    color = { bg = "#b4befe", fg = "#313244" },
    separator = { left = "", right = "" },
}

local encoding = {
    'encoding',
    color = { bg = colors.foreground, fg = "#80A7EA" },
    separator = { left = "", right = "" },
}

local branch = {
    'branch',
    color = { bg = "#a6e3a1", fg = "#313244" },
    separator = { left = "", right = "" },
}

local diff = {
    "diff",
    color = { bg = colors.foreground, fg = "#313244" },
    separator = { left = "", right = "" },
}

local modes = {
    'mode', fmt = function(str) return str end,
    color = function(str)
        local mode_color = {
            n = "#80A7EA",
            i = "#a6e3a1",
            v = "#80A7EA",
            V = "#80A7EA",
            c = "#cdd6f4",
            no = "#cdd6f4",
            s = "#cdd6f4",
            S = "#cdd6f4",
            ic = "#a6e3a1",
            R = "#fab387",
            Rv = "#fab387",
            cv = "#cdd6f4",
            ce = "#cdd6f4",
            r = "#cdd6f4",
            rm = "#cdd6f4",
            ["r?"] = "#cdd6f4",
            ["!"] = "#cdd6f4",
            t = "#cdd6f4",
        }
        return { bg = mode_color[str], fg = "#313244" }
    end,
    separator = { left = "", right = "" },
}

local function getLspName()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
        return msg
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return "  " .. client.name
        end
    end
    return "  " .. msg
end

local copilot = {
    'copilot',
    separator = { left = "", right = "" },
    color = { bg = colors.foreground, fg = "red"},
}

local gitblame = {
    git_blame.get_current_blame_text,
    cond = git_blame.is_blame_text_available,
    separator = { left = "", right = "" },
    color = { bg = colors.foreground, fg = "white"},
}

local dia = {
    'diagnostics',
    color = { bg = colors.foreground, fg = "#80A7EA" },
    separator = { left = "", right = "" },
}

local lsp = {
    function()
        return getLspName()
    end,
    separator = { left = "", right = "" },
    color = { bg = "#f38ba8", fg = "#1e1e2e" },
}

require('lualine').setup {

    options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },

    sections = {
        lualine_a = {
            --{ 'mode', fmt = function(str) return str:gsub(str, "  ") end },
            modes,
            vim_icons,
            --{ 'mode', fmt = function(str) return str:sub(1, 1) end },
        },
        lualine_b = {
            space,
        },
        lualine_c = {
            filename,
            filetype,
            space,
            branch,
            diff,
            space,
        },
        lualine_x = {
            gitblame,
            space,
            copilot,
            space,
        },
        lualine_y = {
            encoding,
            fileformat,
            space,
        },
        lualine_z = {
            dia,
            lsp,
        }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
}
