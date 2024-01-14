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

--Resize windows using + and -
vim.keymap.set("n", "+", "<cmd>vert res +5<cr>")
vim.keymap.set("n", "-", "<cmd>vert res -5<cr>")
