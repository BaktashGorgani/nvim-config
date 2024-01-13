local chadtree_settings = {
	["view.width"] = 35,
	["theme.icon_glyph_set"] = "emoji",
	["theme.text_colour_set"] = "trapdoor",
	["view.window_options"] = {
		["number"]= true,
		["relativenumber"]= true,
	},
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

vim.keymap.set("n", "<leader>v", "<cmd>CHADopen<cr>")

vim.api.nvim_create_autocmd("StdinReadPre", {
	pattern = "*",
	command = "let s:std_in=1"
})
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	command = "if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') \z
		| execute 'CHADopen --nofocus' | execute 'cd '.argv()[0] | endif"
})
