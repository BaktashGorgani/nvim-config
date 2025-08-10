local ok_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not ok_lspconfig then
    vim.notify('lspconfig not available', vim.log.levels.CRITICAL)
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
        ensure_installed = { 'lua_ls', 'bashls', 'gopls', 'rust_analyzer', 'jedi_language_server' },
    })
end

local on_attach = function(client, bufnr)
    vim.notify('LSP attached: '..client.name..' to buffer '..bufnr, vim.log.levels.INFO)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({'n','v'}, '<A-TAB>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>ff', function()
        vim.notify('LSP formatting requested', vim.log.levels.DEBUG)
        vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.get_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.get_next, opts)
    vim.notify('on_attach completed for '..client.name, vim.log.levels.INFO)
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

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
            on_attach = on_attach,
        })
        return
    end
    if lspconfig[server] then
        lspconfig[server].setup({ on_attach = on_attach })
    else
        vim.notify('LSP server not found in lspconfig: '..server, vim.log.levels.WARN)
    end
end

if type(mason_lspconfig.setup_handlers) == 'function' then
    vim.notify('Configuring servers via mason-lspconfig handlers', vim.log.levels.INFO)
    mason_lspconfig.setup_handlers({
        function(server)
            setup_server(server)
        end,
        ['lua_ls'] = function()
            setup_server('lua_ls')
        end,
    })
else
    vim.notify('mason-lspconfig.setup_handlers unavailable; falling back to manual setup', vim.log.levels.WARN)
    local installed = {}
    if type(mason_lspconfig.get_installed_servers) == 'function' then
        installed = mason_lspconfig.get_installed_servers()
        if #installed == 0 then
            vim.notify('No servers reported by mason-lspconfig; using default list', vim.log.levels.WARN)
            installed = { 'lua_ls', 'bashls', 'gopls', 'rust_analyzer', 'jedi_language_server' }
        end
    else
        vim.notify('mason-lspconfig.get_installed_servers unavailable; using default list', vim.log.levels.WARN)
        installed = { 'lua_ls', 'bashls', 'gopls', 'rust_analyzer', 'jedi_language_server' }
    end
    for _, server in ipairs(installed) do
        setup_server(server)
    end
end

if lspconfig.hyprls then
    lspconfig.hyprls.setup({ on_attach = on_attach })
end
