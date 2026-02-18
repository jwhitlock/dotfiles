-- Thanks to https://github.com/nvim-lua/kickstart.nvim for initial version
-- Language Server Protocol definitions
-- https://github.com/neovim/nvim-lspconfig

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'mason-org/mason.nvim', opts = {}, version = '^2.0.0' }, -- Must be first
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',
  },
  config = function()
    require('mason').setup()
    require('mason-tool-installer').setup {
      ensure_installed = {
        -- Lua
        -- https://luals.github.io/
        'lua_ls',
        'stylua', -- Formats lua code

        -- Typescript
        'ts_ls',

        -- Python
        -- https://github.com/python-lsp/python-lsp-server
        'pylsp',

        -- Spelling
        -- https://github.com/crate-ci/typos
        -- https://github.com/tekumara/typos-lsp
        'typos_lsp',

        -- TOML
        'taplo',

        -- Groovy (JenkinsFile)
        -- https://github.com/GroovyLanguageServer/groovy-language-server
        -- "groovyls",
      },
    }
    require('mason-lspconfig').setup {
      automatic_enable = false,
      ensure_installed = {},
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
