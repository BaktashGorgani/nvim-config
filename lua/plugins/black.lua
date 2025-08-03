return {
    'psf/black',
    branch = 'stable',
    ft = 'python',
    config =function ()
        vim.cmd('autocmd BufWritePre *.py execute ":IsortSync"')
        vim.cmd('autocmd BufWritePre *.py execute ":Black"')
    end
}
