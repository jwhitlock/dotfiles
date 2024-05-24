
return {
    'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"},
                        },
                    }
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

