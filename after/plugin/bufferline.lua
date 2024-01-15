local bufferline = require("bufferline")

vim.opt.termguicolors = true
--require("bufferline").setup {
--	options = {
--		offsets = {
--			{
--				filetype = "neo-tree",
--				text = "File Explorer",
--				separator = true,
--			}
--		}
--	},
--}
bufferline.setup({
	options = {
--		indicator = {
--			buffer_close_icon = ' ',
--			modified_icon = '●',
--			close_icon = ' ',
--		},
		style_preset = bufferline.style_preset.minimal,
		hover = {
			enabled = true,
			delay = 200,
			reveal = {'close'}
		},
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				separator = true,
			},
		},
	},
})
