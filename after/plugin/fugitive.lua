--Git pull(fetch & merge), push, and status
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set("n", "<leader>gf", "<cmd>Git pull<cr>")
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>")

--Git Log
vim.keymap.set("n", "<leader>gl", "<cmd>Git log<cr>")
