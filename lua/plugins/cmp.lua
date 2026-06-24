local cmp = require 'cmp'

-- Get colors from Catppuccin Mocha
local catppuccin = require('catppuccin.palettes').get_palette("mocha")
local border_color = catppuccin.blue

-- Snippet configuration
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },

    -- Window appearance with border
    window = {
        completion = cmp.config.window.bordered({
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None",
        }),
    },

    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
            vim_item.abbr = vim_item.abbr .. " "
            return vim_item
        end,
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
        { name = 'vsnip' }
    }, {
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' }
    })
})

-- Filetype specific configuration for git
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }
    }, {
        { name = 'buffer' }
    })
})

-- Cmdline configuration
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{ name = 'buffer' }}
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Set border highlight
vim.cmd('highlight CmpBorder guifg=' .. border_color)
vim.cmd('highlight CmpDocBorder guifg=' .. border_color)
