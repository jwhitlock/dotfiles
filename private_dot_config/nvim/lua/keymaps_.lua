vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', {noremap=true, silent=true})
