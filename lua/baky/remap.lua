vim.g.mapleader = " "

--Be able to escape from terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

--Move to any window using alt plus movement keys
vim.keymap.set('t', '<A-h>', [[<C-\><C-N><C-w>h]])
vim.keymap.set('t', '<A-j>', [[<C-\><C-N><C-w>j]])
vim.keymap.set('t', '<A-k>', [[<C-\><C-N><C-w>k]])
vim.keymap.set('t', '<A-l>', [[<C-\><C-N><C-w>l]])
vim.keymap.set('i', '<A-h>', [[<C-\><C-N><C-w>h]])
vim.keymap.set('i', '<A-j>', [[<C-\><C-N><C-w>j]])
vim.keymap.set('i', '<A-k>', [[<C-\><C-N><C-w>k]])
vim.keymap.set('i', '<A-l>', [[<C-\><C-N><C-w>l]])
vim.keymap.set('n', '<A-h>', [[<C-w>h]])
vim.keymap.set('n', '<A-j>', [[<C-w>j]])
vim.keymap.set('n', '<A-k>', [[<C-w>k]])
vim.keymap.set('n', '<A-l>', [[<C-w>l]])

--Space t to open terminal
vim.keymap.set("n", "<leader>t", "<cmd>terminal<cr>")

--Resize based on splits
vim.keymap.set("n", "<Insert>",[[<C-w>=]])

--Fill Screen horizontally
vim.keymap.set("n", "<Home>", [[<C-w>_]])

--Fill Screen vertically
vim.keymap.set("n", "<End>", [[<C-w>|]])

--For vertical windows, resize windows horizontally using + and -
vim.keymap.set("n", "+", "<cmd>vert res +5<cr>")
vim.keymap.set("n", "-", "<cmd>vert res -5<cr>")

--For horizontal windows, resize windows vertically using PgUp and PgDn
vim.keymap.set("n", "<PageUp>", "<cmd>res +5<cr>")
vim.keymap.set("n", "<PageDown>", "<cmd>res -5<cr>")

--JSON Beautify
vim.keymap.set("n", "<leader>b", "<cmd>%!python -m json.tool<cr>")
