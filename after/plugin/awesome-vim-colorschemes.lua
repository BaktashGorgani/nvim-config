vim.cmd[[set background=dark]]
local colorschemes = {
    "gruvbox-baby",
    "monokai_soda",
    "NeoSolarized",
    "onedark_dark",
    "tokyonight-night",
    "tokyodark",
    "sonokai",
}

local colorscheme = colorschemes[math.random(#colorschemes)]

print("Random colorscheme: " .. colorscheme)

vim.cmd.colorscheme(colorscheme)

vim.api.nvim_set_hl(0, "Search", {
    bold = true,
    italic = true,
    underline = true,
    fg = "NvimDarkGrey1",
    bg = "NvimDarkGreen",
})

vim.api.nvim_set_hl(0, "IncSearch", {
    bold = true,
    italic = true,
    underline = true,
    fg = "NvimDarkGrey1",
    bg = "NvimDarkGreen",
})

vim.api.nvim_set_hl(0, "CurSearch", {
    bold = true,
    italic = true,
    underline = true,
    fg = "NvimDarkGreen",
    bg = "NvimDarkGrey1",
})
