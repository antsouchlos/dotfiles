return {
    {
        "tpope/vim-fugitive",
        keys = { { "<leader>gs", vim.cmd.Git } }
    },
    {
        "rbong/vim-flog",
        dependencies = { "tpope/vim-fugitive" },
        cmd = "Flog"
    }
}
