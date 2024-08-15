vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<CR>', {noremap=true, silent=true, desc="Reload configuration"})

-- Telescope global
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { silent = true, desc = 'Find Files' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { silent = true, desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>fr', telescope_builtin.oldfiles, { silent = true, desc = 'Find Recently Opened Files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { silent = true, desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fc', telescope_builtin.git_commits, { silent = true, desc = 'Search Commits' })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { silent = true, desc = "Go to next diagnostic"})
vim.keymap.set('n', '<leader>d[', vim.diagnostic.goto_next, { silent = true, desc = "Go to next diagnostic"})
vim.keymap.set('n', '<leader>d]', vim.diagnostic.goto_prev, { silent = true, desc = "Go to previous diagnostic"})
vim.keymap.set('n', '<leader>dd', "<cmd>Telescope diagnostics<cr>", { silent=true, desc = "List diagnostics"})
