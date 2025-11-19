return {
    {
        "https://github.com/tpope/vim-fugitive",
        keys = { { "<leader>gs", vim.cmd.Git } }
    },
    {
        "https://github.com/rbong/vim-flog",
        dependencies = { "https://github.com/tpope/vim-fugitive" },
        cmd = "Flog"
    }
}
