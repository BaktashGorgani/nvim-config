require('lualine').setup{
	extensions = {'neo-tree'},
	sections = {
		lualine_c = {require('auto-session.lib').current_session_name}
	}
}
