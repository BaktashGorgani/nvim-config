# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

Overview
- This repo is a Neovim configuration using lazy.nvim as the plugin manager. Entry point is init.lua, which wires settings, keymaps, plugin bootstrap, LSP, autocmds, and colors.

Common commands
- Open Neovim with this config: nvim
- Force plugin sync/update (headless): nvim --headless "+Lazy! sync" +qa
- Update Treesitter parsers: nvim --headless ":TSUpdate" +qa
- Check health (collects diagnostics for providers, LSP, etc.): nvim --headless "+checkhealth" +qa
- Profile startup (requires Neovim 0.9+): nvim --startuptime startup.log +q && tail -n 50 startup.log
- Regenerate remote plugins (needed by isort.nvim once): nvim --headless ":UpdateRemotePlugins" +qa

Language tooling (invoked via Neovim)
- LSP: mason and mason-lspconfig manage servers; lua_ls has a custom on_init. Relevant servers include lua_ls, bashls, gopls, rust_analyzer, jedi_language_server (Python). nvim-lspconfig provides the client configs.
- Formatters/linters (Python):
  - Black and isort run on save via autocmds (plugins/black.lua, plugins/isort.nvim.lua).
  - nvim-lint triggers mypy on BufWritePost.
- Treesitter: ensure_installed includes C, Lua, Vim, Query, Elixir/Heex, JS/HTML, Python, Go; auto_install = true.

Key dev flows
- Plugins are declared as specs under lua/plugins/*.lua and loaded by lazy.nvim via lua/baky/lazy.lua. Use the headless sync command above after changing specs.
- LSP initialization is triggered from lua/plugins/lsp.lua via the mason-lspconfig plugin spec (mason and mason-lspconfig are eager-loaded to ensure setup_handlers are available). LSP behavior and keymaps are centralized in lua/baky/lsp.lua (on_attach sets navigation, code actions, formatting, diagnostics). 
- Editor behavior lives in:
  - lua/baky/settings.lua (options, UI, listchars, fonts, sessionoptions)
  - lua/baky/remap.lua (leader bindings, window navigation/resize, clipboard, utilities)
  - lua/baky/autocmd.lua (yank highlight; Rust format on save; starts hyprls via vim.lsp.start on BufEnter/BufWinEnter for Hypr configs)
  - lua/baky/colorscheme.lua (random colorscheme selection, highlight overrides, lualine theme, gitblame integration)

Running targeted tasks inside Neovim
- Treesitter update: :TSUpdate
- Toggle file explorer (neo-tree): <leader>v
- FZF pickers: <leader>pf (files), <leader>pg (git files), <leader>ps (live grep), <leader>pb (buffers), <leader>pr (recent)
- Trouble diagnostics: <leader>xx (project), <leader>xX (buffer)
- DAP (Python supported): use mapped keys (e.g., <leader>dc continue, <leader>dj step over, <leader>dk step into, <leader>do step out; Python tests via <leader>tc class, <leader>tm method when filetype=python)
- LSP formatting: <leader>ff

High-level architecture
- init.lua
  - Loads, in order: remaps -> settings -> lazy (plugin bootstrap + specs import) -> lsp setup -> autocmds -> colorscheme; disables Copilot at the end.
- Plugin management (lua/baky/lazy.lua)
  - Bootstraps lazy.nvim into stdpath("data")/lazy/lazy.nvim if missing, prepends it to runtimepath, then calls require("lazy").setup with { import = "plugins" }.
  - Enables automatic checker for plugin updates and sets an install-time colorscheme fallback.
- Core editor modules (lua/baky/*.lua)
  - settings.lua: fundamental options and UI behavior.
  - remap.lua: global keymaps and workflow helpers.
  - lsp.lua: resilient setup with pcall for lspconfig/mason/mason-lspconfig, handler-based server initialization, diagnostics configuration, and on_attach keymaps/notifications.
  - autocmd.lua: yank highlight and Rust pre-save formatting.
  - colorscheme.lua: random scheme selection, UI highlight overrides, lualine configuration, and gitblame/Neo-tree color harmonization.
- Plugins (lua/plugins/*.lua)
  - Each file declares one or a small group of specs for lazy.nvim. Notable areas:
    - Language & tooling: nvim-lspconfig, mason(+lspconfig), treesitter, nvim-lint (mypy for Python), black, isort.nvim.
    - UI/UX: neo-tree, noice (+notify), lualine (configured in colorscheme.lua), devicons, which-key, rainbow-delimiters, presence, illuminate, autopairs, surround, trouble.
    - Fuzzy & navigation: fzf-lua (with keymaps, ui-select), harpoon.
    - Debugging: nvim-dap, dap-ui, dap-virtual-text, dap-python (debugpy venv path at ~/.virtualenvs/debugpy/bin/python).
    - Completion/snippets: blink.cmp (+blink-cmp-avante, blink-copilot), LuaSnip + friendly-snippets.
    - Git: fugitive, gitgutter, git-blame.

Notes for future changes
- After modifying lua/plugins/*.lua, run a plugin sync/update (see headless command) to ensure new specs are installed.
- For Python dev, ensure debugpy is installed in ~/.virtualenvs/debugpy; adjust the path in plugins/nvim-dap.lua if your environment differs.
- If lua_ls lacks workspace settings, lsp.lua supplies a default that disables third-party checks and adds VIMRUNTIME to the library.

