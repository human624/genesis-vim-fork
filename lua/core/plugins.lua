local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter' },

  -- LSP
  { 'neovim/nvim-lspconfig' },

  -- Autocomplete
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  { 'williamboman/mason.nvim' },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Dashboard
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {}
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'} }
  },

  -- Utilities
  { 'Eandrju/cellular-automaton.nvim' },
  { 'norcalli/nvim-colorizer.lua' },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },

  -- Colorschemes
  {'ellisonleao/gruvbox.nvim', priority = 1000 , config = true, opts = ...},
  {'catppuccin/nvim', name = "catppuccin", priority = 1000 },

  -- Escape jk/jj mapping
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        timeout = 200,
        default_mappings = false,
        mappings = {
          i = {
            j = {
              k = "<Esc>",
              j = "<Esc>",
            },
          },
        },
      }
    end,
  },

  -- Comment
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },

  -- Bufferline
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  -- ALE
  {
    'dense-analysis/ale',
    config = function()
      local g = vim.g
      g.ale_linters = {
        python = {'mypy'},
        lua = {'lua_language_server'}
      }
    end
  },

  -- Illuminate
  { 'RRethy/vim-illuminate' },

  -- Luarocks
  {
    "vhyrro/luarocks.nvim",
    priority = 1001,
    opts = { rocks = { "magick" } },
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },

  -- ToggleTerm
  {'akinsho/toggleterm.nvim', version = "*", config = true},

  -- WhichKey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- Mini plugins
  { 'echasnovski/mini.nvim', version = false },
  { 'echasnovski/mini.move', version = false },
  { 'echasnovski/mini.pairs', version = false },

})
