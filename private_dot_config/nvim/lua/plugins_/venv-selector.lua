-- Allows selection of python virtual environment from within neovim
-- https://github.com/linux-cultist/venv-selector.nvim/tree/regexp

return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  lazy = false,
  branch = 'regexp', -- Use regexp branch, as suggested on the main page.
  config = function()
    require('venv-selector').setup {
      settings = {
        --[[
        search = {
          my_venvs = {
            command = "fd '/bin/python$' --full-path  ~/.virtualenvs",
          },
        },
        ]]
        --
        options = {
          -- notify_user_on_venv_activation = true,
          debug = true,
        },
      },
    }
  end,
  keys = {
    {
      '<LEADER>vs',
      '<cmd>VenvSelect<cr>',
      '<LEADER>vl',
      '<cmd>VenvSelectLog<cr>',
    },
  },
}
