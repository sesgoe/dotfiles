require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        'bash',
        'comment',
        'dockerfile',
        'graphql',
        'html',
        'javascript',
        'json',
        'json5',
        'lua',
        'markdown',
        'markdown_inline',
        'prisma',
        'proto',
        'query',
        'regex',
        'rust',
        'sql',
        'tsx',
        'typescript',
        'vim',
        'yaml',
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = { enable = true },
    matchup = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        disable = {}
    },
}
