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
        -- Disable all but the venvs I use (pyenv, virtualenvs). List at:
        -- https://github.com/linux-cultist/venv-selector.nvim/blob/regexp/lua/venv-selector/config.lua
        search = {
          -- The default finds too many pythons
          virtualenvs = {
            command = "$FD '/bin/python$' ~/.virtualenvs --full-path --color never",
          },
          hatch = false,
          poetry = false,
          pipenv = false,
          anaconda_envs = false,
          anaconda_base = false,
          miniconda_envs = false,
          miniconda_base = false,
          pipx = false,
          cwd = false,
          workspace = false,
          file = false,
        },
        options = {
          debug = true,
        },
      },
    }
  end,
  keys = {
    {
      '<LEADER>vs',
      '<cmd>VenvSelect<cr>',
    },
    {
      '<LEADER>vl',
      '<cmd>VenvSelectLog<cr>',
    },
  },
}
