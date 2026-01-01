vim.g.mapleader = " "

-- Quit
vim.keymap.set('n', '<C-q>', '<cmd>:q<CR>')

-- Save
vim.keymap.set('i', '<C-s>', '<cmd>:w<CR>')
vim.keymap.set('n', '<C-s>', '<cmd>:w<CR>')

-- Copy all text
vim.keymap.set('n', '<C-a>', '<cmd>%y+<CR>')

-- NvimTree
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<CR>')

-- BufferLine
vim.keymap.set('n','<Tab>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n','<S-Tab>', ':BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<C-l>', ':BufferLineCloseOthers<CR>')

-- TodoList
vim.keymap.set('n', '<leader>nl', ':TodoTelescope<CR>')

-- ToggleTerm
vim.keymap.set('n', '<leader>s', ':ToggleTerm direction=float<CR>')

-- Нормальный режим (Normal Mode Overrides)
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'd', '"_d', opts)        
vim.api.nvim_set_keymap('n', 'dw', '"_dw', opts)      
vim.api.nvim_set_keymap('n', 'db', '"_db', opts)      
vim.api.nvim_set_keymap('n', 'dd', '"_dd', opts)      

-- Визуальный режим (Visual Mode Overrides)
vim.api.nvim_set_keymap('v', 'd', '"_d', opts)        
vim.api.nvim_set_keymap('v', 'x', '"_x', opts)  
