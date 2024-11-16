-- Thanks to https://github.com/nvim-lua/kickstart.nvim for initial version
-- Language Server Protocol definitions
-- https://github.com/neovim/nvim-lspconfig
--
---- LSPs
--
--- Lua - lua_ls
-- https://luals.github.io/
--
--- Python - pylsp
-- https://github.com/python-lsp/python-lsp-server
--
--- Spelling - typos_lsp
-- https://github.com/crate-ci/typos
-- https://github.com/tekumara/typos-lsp
--
--- Groovy (JenkinsFile) - groovy-language-server
-- https://github.com/GroovyLanguageServer/groovy-language-server
--
---- Dependencies
--
--- lsp-config
-- Mason - install LSPs
--

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- Must be first
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },
    -- Allows extra capabilities provided by nvim-cmp
    'hrsh7th/cmp-nvim-lsp',

    -- For workaround
    'nvim-lua/plenary.nvim',
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated
    --    with an lsp (for example, opening `main.rs` is associated with
    --    `rust_analyzer`) this function will be executed to configure the
    --    current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- map lets us more easily define mappings specific for LSP related
        -- items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end

        -- Update pylsp configuration for virtualenv
        if client and client.name == 'pylsp' then
          local logger = require 'venv-selector.logger'
          local vs = require 'venv-selector'
          local py_path = vs and vs.python() or nil
          local v_path = vs and vs.venv() or nil
          logger.info 'Starting LspAttach event for pylsp...'
          if not (v_path and py_path) then
            logger.info(' abort, venv_path=' .. (v_path or 'nil') .. ' and python_path=' .. (py_path or 'nil'))
          else
            logger.info(' old settings: ' .. vim.fn.json_encode(client.settings))
            local overrides = {
              pylsp = {
                plugins = {
                  jedi = { environment = py_path },
                  ruff = { executable = vim.fs.joinpath(v_path, 'bin', 'ruff') },
                  mypy = {
                    overrides = { '--python-executable', py_path, true },
                  },
                },
              },
            }
            local new_plug = overrides.pylsp.plugins
            local old_plug = client.settings.pylsp.plugins
            if
              old_plug.jedi
              and new_plug.jedi.environment == old_plug.jedi.environment
              and old_plug.ruff
              and new_plug.ruff.executable == old_plug.ruff.executable
              and old_plug.mypy
              and old_plug.mypy.overrides
              and new_plug.mypy.overrides[2] == old_plug.mypy.overrides[2]
            then
              logger.info ' no changes to settings'
            else
              local new_settings = vim.tbl_deep_extend('force', client.settings, overrides)
              logger.info(' new setting:' .. vim.fn.json_encode(new_settings))
              client.notify('workspace/didChangeConfiguration', { settings = new_settings })
              client.settings = new_settings
              logger.info ' done!'
            end
          end
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      ts_ls = {},
      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      pylsp = {
        -- Debug variant
        -- cmd = { 'pylsp', '-vvv', '--log-file', '/tmp/lsp.log' },
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = false },
              mccabe = { enabled = false },
              pycodestyle = { enabled = false },
              pydocstyle = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              flake8 = { enabled = false },
              pylint = { enabled = false },
              black = { enabled = true },
              mypy = { enabled = true },
              ruff = { enabled = true },
            },
          },
        },
      },
      typos_lsp = {
        init_options = {
          config = '~/.config/typos/typos.toml',
        },
      },
      taplo = {},
      groovyls = {},
    }

    --- Install python-lsp-server plugins in the same environment
    --- https://github.com/williamboman/mason-lspconfig.nvim/issues/58#issuecomment-1521738021
    local mason_post_install = function(pkg)
      if pkg.name ~= 'python-lsp-server' then
        return
      end

      local venv = vim.fn.stdpath 'data' .. '/mason/packages/python-lsp-server/venv'
      local job = require 'plenary.job'

      job
        :new({
          command = venv .. '/bin/pip',
          args = {
            'install',
            '-U',
            '--disable-pip-version-check',
            'pylsp-rope',
            'python-lsp-black',
            'pylsp-mypy',
            'python-lsp-ruff',
          },
          cwd = venv,
          env = { VIRTUAL_ENV = venv },
          on_exit = function()
            print 'Finished installing pylsp modules.'
          end,
          on_start = function()
            print 'Installing pylsp modules...'
          end,
        })
        :start()
    end

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    require('mason').setup()
    require('mason-registry'):on('package:install:success', mason_post_install)

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
