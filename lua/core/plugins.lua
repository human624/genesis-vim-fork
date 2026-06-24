local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Treesitter for better syntax highlighting
  { 'nvim-treesitter/nvim-treesitter' },

  -- LSP and Autocompletion
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  { 'williamboman/mason.nvim' },
  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/vim-vsnip' },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- UI & Dashboard
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function() require('dashboard').setup {} end,
    dependencies = { {'nvim-tree/nvim-web-devicons'} }
  },

  -- Utilities & Aesthetics
  { 'Eandrju/cellular-automaton.nvim' },
  { 'catgoose/nvim-colorizer.lua' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- Colorschemes
  {'ellisonleao/gruvbox.nvim', priority = 1000 , config = true },
  {'catppuccin/nvim', name = "catppuccin", priority = 1000 },
  {'rose-pine/neovim', name = "rose-pine", priority = 1000 },

  -- Typing helpers
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        timeout = 200,
        default_mappings = false,
        mappings = { i = { j = { k = "<Esc>", j = "<Esc>" } } },
      }
    end,
  },
  { 'numToStr/Comment.nvim', opts = {}, lazy = false },

  -- Buffer & File management
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("nvim-tree").setup {} end,
  },

  -- Editor tools
  { 'RRethy/vim-illuminate' },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  {'akinsho/toggleterm.nvim', version = "*", config = true},

  -- WhichKey for keymap hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- Mini.nvim suite
  { 'echasnovski/mini.nvim', version = false },
  { 'echasnovski/mini.move', version = false },
  { 'echasnovski/mini.pairs', version = false },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
})
