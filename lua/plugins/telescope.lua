-- Telescope
local builtin = require('telescope.builtin')

-- Files and buffers
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>ft', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Git functionality
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {desc = "List git branches"})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {desc = "List git commits"})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {desc = "List git status"})

-- Colorscheme
vim.keymap.set('n', '<leader>cs', builtin.colorscheme, {})
