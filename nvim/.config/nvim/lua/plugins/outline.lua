return {
    "https://github.com/hedyhli/outline.nvim",
    keys = {
        { "<leader>l", "<cmd>Outline<CR>", desc = "Toggle Outline" }
    },
    opts = {
        outline_window = {
            focus_on_open = false,
        },
        symbol_folding = {
            autofold_depth = 3,
            markers = { '', '' },
        },
    }
}
