-- Убираем всплывающие предупреждения про deprecated API
vim.deprecate = function(...) end

-- Core
require('core.plugins')
require('core.mappings')
require('core.colors')
require('core.configs')

-- Editor Functionality
require('plugins.nvim-tree')
require('plugins.treesitter')
require('plugins.lsp')
require('plugins.cmp')
require('plugins.mason')
require('plugins.telescope')

-- UI & Visuals
require('plugins.dashboard')
require('plugins.colorizer')
require('plugins.lualine')
require('plugins.cellular')
require('plugins.bufferline')

-- Utilities / Coding Helpers
require('plugins.comment')
require('plugins.todo')
require('plugins.trouble')
require('plugins.toggleterm')
require('plugins.whichkey')
require('plugins.mini')
