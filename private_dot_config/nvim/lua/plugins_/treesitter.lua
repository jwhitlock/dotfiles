return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "bash",
                "comment",
                "css",
                "csv",
                "diff",
                "dockerfile",
                "dot",
                "fish",
                "html",
                "http",
                "javascript",
                "jq",
                "json",
                "lua",
                "luadoc",
                "make",
                "markdown",
		"python",
		"sql",
		"ssh_config",
		"toml",
		"typescript",
		"vim",
		"xml",
		"yaml",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
