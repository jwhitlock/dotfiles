-- Showing available keybindings in a popup as you type
-- https://github.com/folke/which-key.nvim
-- See :help autocmd-events

return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Loads which-key before UI elements are loaded
  config = function() -- Runs after loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    }
  end,
}
