vim.g.mapleader = " "
local opts = { silent = true }

-- === Quick Actions ===
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', opts)
vim.keymap.set({ 'i', 'n' }, '<C-s>', '<cmd>w<CR>', opts)
vim.keymap.set('n', '<C-a>', '<cmd>%y+<CR>', opts)

-- === NvimTree Mappings ===
vim.keymap.set('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '<leader>tf', '<cmd>NvimTreeFocus<CR>', opts)

-- === BufferLine Mappings ===
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', opts)
vim.keymap.set('n', '<C-l>', '<cmd>BufferLineCloseOthers<CR>', opts)

-- === Utility Mappings ===
vim.keymap.set('n', '<leader>nl', '<cmd>TodoTelescope<CR>', opts)
vim.keymap.set('n', '<leader>ts', '<cmd>ToggleTerm direction=float<CR>', opts)

-- === Delete Behavior (Black hole register) ===
vim.keymap.set('n', 'd', '"_d', opts)
vim.keymap.set('n', 'dw', '"_dw', opts)
vim.keymap.set('n', 'db', '"_db', opts)
vim.keymap.set('n', 'dd', '"_dd', opts)
vim.keymap.set('v', 'd', '"_d', opts)
vim.keymap.set('v', 'x', '"_x', opts)
