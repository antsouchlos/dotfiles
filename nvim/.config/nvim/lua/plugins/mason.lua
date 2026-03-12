return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        {
            'williamboman/mason.nvim',
            opts = {
                registries = {
                    "github:antsouchlos/mason-registry",
                    "github:mason-org/mason-registry"
                }
            }
        },
        "neovim/nvim-lspconfig",
    },
    event = "VeryLazy",
    config = true,
}
