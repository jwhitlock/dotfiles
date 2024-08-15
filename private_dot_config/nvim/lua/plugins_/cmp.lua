--- Completion
--- https://github.com/hrsh7th/nvim-cmp

return {
    "hrsh7th/nvim-cmp",
    config = function(_, opts)
        local cmp = require('cmp')
        cmp.setup {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'luasnip' },
            })
        }

        end,
    dependencies = {
        'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', -- LuaSnip support
        'hrsh7th/cmp-buffer',  -- complete from the current buffer
        'hrsh7th/cmp-cmdline', -- cmdline completions
        'hrsh7th/cmp-nvim-lsp', -- lsp completions
        'hrsh7th/cmp-nvim-lua', -- complete lua code
        'hrsh7th/cmp-path',    -- complete with file names
    },
}
