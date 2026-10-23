return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",

        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                branch = "main",
            },
        },

        config = function()
            local treesitter = require("nvim-treesitter")

            treesitter.install({
                "cpp",
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })

            require("nvim-treesitter-textobjects").setup({
                move = {
                    set_jumps = false,
                },
                select = {
                    lookahead = true,
                },
            })

            local move = require("nvim-treesitter-textobjects.move")
            local select = require("nvim-treesitter-textobjects.select")

            vim.keymap.set({ "n", "x", "o" }, "]c", function()
                move.goto_next_start("@code_cell.inner", "textobjects")
            end, { desc = "next code block" })

            vim.keymap.set({ "n", "x", "o" }, "]j", function()
                move.goto_next_start("@cellseparator", "textobjects")
            end, { desc = "next cell" })

            vim.keymap.set({ "n", "x", "o" }, "[c", function()
                move.goto_previous_start("@code_cell.inner", "textobjects")
            end, { desc = "previous code block" })

            vim.keymap.set({ "n", "x", "o" }, "[j", function()
                move.goto_previous_start("@cellseparator", "textobjects")
            end, { desc = "previous cell" })

            vim.keymap.set({ "x", "o" }, "ic", function()
                select.select_textobject("@code_cell.inner", "textobjects")
            end, { desc = "in code block" })

            vim.keymap.set({ "x", "o" }, "ac", function()
                select.select_textobject("@code_cell.outer", "textobjects")
            end, { desc = "around code block" })

            vim.keymap.set({ "x", "o" }, "aj", function()
                select.select_textobject("@cell", "textobjects")
            end, { desc = "cell" })

            vim.keymap.set({ "x", "o" }, "ij", function()
                select.select_textobject("@cellcontent", "textobjects")
            end, { desc = "cell content" })
        end,
    },
}

