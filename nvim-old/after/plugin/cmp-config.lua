local cmp = require 'cmp'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup(
    {
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<S-Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
            ["<C-e>"] = cmp.mapping.abort(), -- close completion window
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = {
            { name = 'nvim_lsp', priority = 10 },
            { name = 'nvim_lua', priority = 8 },
            { name = 'nvim_lsp_signature_help', priority = 8 },
            { name = 'luasnip', priority = 7 },
            { name = 'buffer', priority = 5 },
            { name = 'path' },
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                cmp.config.compare.order,
            }
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        formatting = {
            format = require("lspkind").cmp_format(
                {
                    with_text = true,
                    menu = ({
                        buffer = "",
                        nvim_lsp = "λ",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[Latex]",
                    })
                }
            )
        },
        experimental = { ghost_text = true }
    }
)

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
