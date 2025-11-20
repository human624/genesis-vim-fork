local cmp = require 'cmp'

-- Snippet configuration
cmp.setup({
    snippet = {
        expand = function(args)
            -- Вставка сниппетов (разкомментируй нужный движок)
            -- vim.fn["vsnip#anonymous"](args.body)
            -- require('luasnip').lsp_expand(args.body)
            -- require('snippy').expand_snippet(args.body)
            -- vim.fn["UltiSnips#Anon"](args.body)
        end
    },

    -- Window appearance
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },

    -- Key mappings
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {"i", "s"})
    }),

    -- Completion sources
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' } -- Для vsnip пользователей
    }, {
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' }
    })
})

-- Filetype specific configuration
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' } -- Только для gitcommit
    }, {
        { name = 'buffer' }
    })
})

-- Cmdline configuration
-- Для поиска через / и ?
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{ name = 'buffer' }}
})

-- Для команд через :
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- LSP capabilities setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['ts_ls'].setup { capabilities = capabilities }
