return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branxh = "main",
    lazy = false,     -- This plugin doesn't support lazy loading
    config = function(_, opts)
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "cpp",
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query"
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = {
                    "latex"
                }
            }
        })
    end
}
