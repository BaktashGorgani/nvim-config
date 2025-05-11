local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

--Extension keymaps
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
vim.keymap.set("n", "<leader>z", "<cmd>Telescope aerial<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope flutter commands<cr>")
vim.keymap.set("n", "<leader>n", "<cmd>Telescope notify<cr>")


--Toggle showing hidden files
--Ripped from https://github.com/nvim-telescope/telescope.nvim/issues/2874#issuecomment-1900967890

local my_find_files
my_find_files = function(opts, no_ignore)
  opts = opts or {}
  no_ignore = vim.F.if_nil(no_ignore, false)
  opts.attach_mappings = function(_, map)
    map({ "n", "i" }, "<C-h>", function(prompt_bufnr) -- <C-h> to toggle modes
      local prompt = require("telescope.actions.state").get_current_line()
      require("telescope.actions").close(prompt_bufnr)
      no_ignore = not no_ignore
      my_find_files({ default_text = prompt }, no_ignore)
    end)
    return true
  end

  if no_ignore then
    opts.no_ignore = true
    opts.hidden = true
    opts.prompt_title = "Find Files <ALL>"
    require("telescope.builtin").find_files(opts)
  else
    opts.prompt_title = "Find Files"
    require("telescope.builtin").find_files(opts)
  end
end

vim.keymap.set("n", '<leader>pf', my_find_files)
