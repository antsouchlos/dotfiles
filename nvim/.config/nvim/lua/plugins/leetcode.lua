-- TODO: Lazy loading
return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        picker = { provider = "fzf-lua" },
    },
}
