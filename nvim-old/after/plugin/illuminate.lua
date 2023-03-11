require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
        'NvimTree'
    },
    min_count_to_highlight = 2,
})

vim.cmd [[hi def IlluminatedWordText gui=underline]]
vim.cmd [[hi def IlluminatedWordRead gui=underline]]
vim.cmd [[hi def IlluminatedWordWrite gui=underline]]
