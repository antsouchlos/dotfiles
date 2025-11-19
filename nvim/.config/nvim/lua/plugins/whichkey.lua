return {
    "https://github.com/folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    event = "VeryLazy",
    opts = {
        -- TODO: Add names for other nameless keymaps, e.g.,
        -- defaults = {
        --     ["<leader>x"] = { name = "+Trouble" }
        -- }
    },
    config = function(_, opts)
        require("which-key").setup(opts)

        require("which-key").add({
            { "<leader>d", group = "Debug" },
            { "<leader>f", group = "Find" },
            { "<leader>l", group = "LSP" },
            { "<leader>o", group = "Overseer" },
            { "<leader>s", group = "Session" },
            { "<leader>x", group = "Trouble" }
        })
    end
}
