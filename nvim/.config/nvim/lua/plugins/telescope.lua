return {
    "https://github.com/nvim-telescope/telescope.nvim",
    dependencies = {
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    },
    cmd = { "Telescope" },
    keys = {
        { "<leader>ff", function() require("telescope.builtin").find_files() end,                  desc = "Files" },
        { "<leader>fg", function() require("telescope.builtin").live_grep() end,                   desc = "grep" },
        { "<leader>fa", function() require("telescope.builtin").find_files({ hidden = true }) end, desc = "All files" },
        { "<leader>fb", function() require("telescope.builtin").buffers() end,                     desc = "Buffers" },
        { "<leader>fh", function() require("telescope.builtin").help_tags() end,                   desc = "Help tags" }
    },
    config = function()
        require("telescope").setup {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown()
                }
            }
        }
    end
}
