return {
    "hedyhli/outline.nvim",
    keys = {
        { "<leader>l", "<cmd>Outline<CR>", desc = "Toggle Outline" }
    },
    config = function()
        require('outline').setup({
            outline_window = {
                focus_on_open = false,
            },
            symbol_folding = {
                autofold_depth = 1,
                markers = { '', '' },
            },
            providers = {
                priority = { 'lsp', 'coc', 'markdown', 'norg', 'treesitter' },
            },
        })
    end,
    dependencies = {
        'epheien/outline-treesitter-provider.nvim'
    }
}
