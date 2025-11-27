return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>ff", function() require("fzf-lua").files() end,          desc = "Files" },
        { "<leader>fg", function() require("fzf-lua").live_grep() end,      desc = "grep" },
        { "<leader>fa", function() require("fzf-lua").files() end,          desc = "All files" },
        { "<leader>fb", function() require("fzf-lua").buffers() end,        desc = "Buffers" },
        { "<leader>fh", function() require("fzf-lua").helptags() end,       desc = "Help tags" },
    },
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup()
        fzf.register_ui_select()
    end
}
