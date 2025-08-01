local builtin = require('fzf-lua')
vim.keymap.set('n', '<leader>pc', builtin.builtin, {})
vim.keymap.set('n', '<leader>pf', builtin.files, {})
vim.keymap.set('n', '<leader>pr', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})

builtin.register_ui_select()
