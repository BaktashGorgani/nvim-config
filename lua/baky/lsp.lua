local ok_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not ok_lspconfig then
    vim.notify('lspconfig not available', vim.log.levels.ERROR)
end

local ok_mason, mason = pcall(require, 'mason')
if ok_mason then
    mason.setup()
else
    vim.notify('mason not available', vim.log.levels.WARN)
end

local ok_mason_lsp, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not ok_mason_lsp then
    vim.notify('mason-lspconfig not available; using fallback', vim.log.levels.WARN)
    mason_lspconfig = {}
else
    mason_lspconfig.setup({
        ensure_installed = { 'lua_ls', 'bashls', 'gopls', 'rust_analyzer', 'jedi_language_server', 'html' },
        automatic_enable = { exclude = { 'rust_analyzer' }, },
    })
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Godot: the GDScript language server is built into the Godot editor itself and
-- is reached over TCP (127.0.0.1:6005 by default, override with $GDScript_Port),
-- so mason cannot install it. The editor must be running for the client to attach.
-- nvim-lspconfig ships lsp/gdscript.lua, so vim.lsp.enable picks the config up.
vim.lsp.enable('gdscript')

local function setup_server(server)
    if server == 'lua_ls' then
        lspconfig.lua_ls.setup({
            on_init = function(client)
                vim.notify('lua_ls on_init', vim.log.levels.DEBUG)
                local path = client.workspace_folders[1].name
                if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT'
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME
                                }
                            }
                        }
                    })
                    client:notify('workspace/didChangeConfiguration', { settings = client.config.settings })
                end
                return true
            end,
        })
        return
    end
    if lspconfig[server] then
        lspconfig[server].setup()
    else
        vim.notify('LSP server not found in lspconfig: '..server, vim.log.levels.WARN)
    end
end

if type(mason_lspconfig.setup_handlers) == 'function' then
    mason_lspconfig.setup_handlers({
        function(server)
            setup_server(server)
        end,
        ['lua_ls'] = function()
            setup_server('lua_ls')
        end,
    })
else
    -- mason-lspconfig not ready; do nothing (plugin loader will run this module when ready)
    return
end
