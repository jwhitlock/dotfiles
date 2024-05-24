-- Language Server Protocol definitions
--
---- LSPs
--
--- Lua - lua_ls
-- https://luals.github.io/
--
--- Python - pylsp
-- https://github.com/python-lsp/python-lsp-serve
--
--- Spelling - typos_lsp
-- https://github.com/crate-ci/typos
-- https://github.com/tekumara/typos-lsp
--
---- Dependencies
--
--- lsp-config
-- https://github.com/neovim/nvim-lspconfig
-- Mason - install LSPs
--

return {
    'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspconfig.lua_ls.setup {
                capabilities= capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"},
                        },
                    }
                }
            }
            lspconfig.pylsp.setup{
                capabilities = capabilities,
                on_attach = function()
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
                    vim.keymap.set("n", "gr", vim.lsp.buf.referring, {buffer=0})
                    vim.keymap.set("n", "<leader>s", vim.lsp.buf.rename, {buffer=0})
                end,
            }
            lspconfig.typos_lsp.setup {
                capabilities=capabilities,
                init_options = {
                    config = '~/.config/typos/typos.toml',
                }
            }
        end,
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        build = ':MasonUpdate',
        config = function()
            require('mason-lspconfig').setup {
                ensure_installed = {
                    "lua_ls",
                    "pylsp",
                    "typos_lsp",
                }
            }
            require('mason-lspconfig').setup_handlers {
                function (server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }
        end,
        dependencies = {
            'williamboman/mason.nvim',
            config = function()
                require("mason").setup()
            end,
        },
    },
}

