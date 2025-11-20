local lspconfig = require('lspconfig')

-- Python (Pyright)
lspconfig.pyright.setup {
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { '*' },
            },
        },
    },
    -- Устанавливаем одинаковую кодировку позиций для Pyright и Ruff
    capabilities = {
        textDocument = {
            synchronization = {
                dynamicRegistration = true,
            },
        },
    },
    positionEncodings = { "utf-8" },  -- Добавлено
}

-- TypeScript / JavaScript (пример)
lspconfig.ts_ls.setup({})

-- Rust
lspconfig.rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {},
    },
}

-- Ruff Linter
lspconfig.ruff.setup {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    init_options = {
        settings = {
            args = {
                "--select=E,F,UP,N,I,ASYNC,S,PTH",
                "--line-length=79",
                "--respect-gitignore",  -- Исключать из сканирования файлы в .gitignore
                "--target-version=py311"
            },
        }
    },
    -- Устанавливаем одинаковую кодировку позиций для Ruff
    capabilities = {
        textDocument = {
            synchronization = {
                dynamicRegistration = true,
            },
        },
    },
    positionEncodings = { "utf-8" },  -- Добавлено
}

-- Global diagnostic mappings
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- LSP buffer-local mappings
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings
        local opts = { buffer = ev.buf }

        -- Navigation
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

        -- Actions
        vim.keymap.set({ 'n', 'v' }, '<space>r', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

