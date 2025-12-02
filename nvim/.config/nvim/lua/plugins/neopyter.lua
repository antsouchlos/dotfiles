return {
    "SUSTech-data/neopyter",
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'AbaoFromCUG/websocket.nvim',
    },
    opts = {
        mode = "direct",
        remote_address = "127.0.0.1:9001",
        file_pattern = { "*.ju.*" },
    },
    ft = { "python" },
    config = function(_, opts)
        local neopyter = require("neopyter")
        neopyter.setup({ opts })

        vim.keymap.set("n", "<leader>jr", "<cmd>Neopyter execute notebook:run-cell<CR>", { desc = "run selected" })
        vim.keymap.set("n", "<leader>jR", "<cmd>Neopyter execute notebook:run-cell-and-select-next<CR>",
            { desc = "run selected and select next" })
        vim.keymap.set("n", "<leader>ja", "<cmd>Neopyter execute notebook:run-all-cells<CR>",
            { desc = "run all above cell" })

        vim.keymap.set("n", "<leader>jt", "<cmd>Neopyter execute kernelmenu:restart<CR>", { desc = "restart kernel" })
    end,
}
