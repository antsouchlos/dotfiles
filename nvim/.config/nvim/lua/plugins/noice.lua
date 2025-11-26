return {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",
    opts = {
        views = {
            history = {
                { event = "lsp", kind = "" },
            },
            cmdline_popup = {
                backend = "popup",
                relative = "editor",
                position = {
                    row = -1,
                    col = "0%"
                },
                border = { style = "none" }
            },
            cmdline_popupmenu = {
                relative = "editor",
                position = {
                    row = -2,
                    col = "0%"
                }
            },
            mini = {
                border = { style = "rounded" },
                position = {
                    row = -2,
                    col = "100%",
                },
                size = {
                    max_width = 50,
                    max_height = 4,
                },
            }
        }
    }
}
