
return {
    'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
	config = function(_, opts)
	end,
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        build = ':MasonUpdate',
        config = function(_, opts)
            require('mason-lspconfig').setup()
            require('mason-lspconfig').setup_handlers {
                function (server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }
        end,
        dependencies = {
            'williamboman/mason.nvim',
            config = function(_, opts)
                require("mason").setup()
            end,
        },
    },
}

