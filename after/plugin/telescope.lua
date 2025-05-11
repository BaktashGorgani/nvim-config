local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

--Extension keymaps
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
vim.keymap.set("n", "<leader>z", "<cmd>Telescope aerial<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope flutter commands<cr>")
vim.keymap.set("n", "<leader>n", "<cmd>Telescope notify<cr>")
