return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", config = true },
        "neovim/nvim-lspconfig",
    },
    event = "VeryLazy",
    config = true,
}
