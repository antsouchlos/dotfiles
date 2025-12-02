return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = "v0.10.0",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ":TSUpdate",
        lazy = false, -- This plugin doesn't support lazy loading
        config = function()
            require("nvim-treesitter").setup()

            require("nvim-treesitter.configs").setup({
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = false,
                        goto_next_start = {
                            ["]c"] = { query = "@code_cell.inner", desc = "next code block" },
                            ["]j"] = { quer = "@cellseparator", desc = "next cell" },
                        },
                        goto_previous_start = {
                            ["[c"] = { query = "@code_cell.inner", desc = "previous code block" },
                            ["[j"] = { query = "@cellseparator", desc = "next code block" },
                        },
                    },
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["ic"] = { query = "@code_cell.inner", desc = "in code block" },
                            ["ac"] = { query = "@code_cell.outer", desc = "around code block" },
                            ["aj"] = { query = "@cell", desc = "cell" },
                            ["ij"] = { query = "@cellcontent", desc = "cell content" },
                        },
                    },
                },
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
}
