local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Diagnostic icons configuration
local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = "󰋽 " }
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN]  = signs.Warn,
      [vim.diagnostic.severity.HINT]  = signs.Hint,
      [vim.diagnostic.severity.INFO]  = signs.Info,
    }
  },
  virtual_text = { prefix = '●' },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = { border = "rounded" },
})

-- Server Configurations
vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  cmd = { "lua-language-server", "--force_accept_workspace" },
  root_dir = function(fname)
    local root = vim.fs.root(fname, { '.luarc.json', '.luarc.jsonc', 'init.lua' })
    return root or vim.fs.dirname(fname)
  end,
  settings = { Lua = { diagnostics = { globals = { 'vim' } }, telemetry = { enable = false } } },
})

vim.lsp.config('pyright', {
  capabilities = capabilities,
  settings = { pyright = { disableOrganizeImports = true }, python = { analysis = {} } },
  offset_encoding = "utf-8",
})

vim.lsp.config('ruff', {
  capabilities = capabilities,
  init_options = { settings = { args = { "--select=E,F,UP,N,I,ASYNC,S,PTH", "--line-length=79" } } },
  offset_encoding = "utf-8",
})

vim.lsp.enable({ 'lua_ls', 'pyright', 'ruff', 'ts_ls', 'rust_analyzer' })

-- Global diagnostic mappings
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- LSP Attach functionality
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
  end,
})
