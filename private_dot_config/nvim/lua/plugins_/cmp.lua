return {
    "hrsh7th/nvim-cmp",
    config = function(_, opts)
        require('cmp').setup {
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            }
        }
    end,
}
