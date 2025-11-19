return {
    "https://github.com/rmagatti/auto-session",
    -- TODO: This forces telescope to be loaded non-lazily. Is there a way to fix this?
    dependencies = {
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-telescope/telescope.nvim",
        "https://github.com/nvim-lualine/lualine.nvim"
    },
    init = function()
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    keys = {
        { '<leader>ss', '<cmd>AutoSession save<CR>',       desc = "Save" },
        { '<leader>sd', '<cmd>AutoSession delete<CR>',     desc = "Delete" },
        { '<leader>fs', '<cmd>Telescope session-lens<CR>', desc = "Session" }
    },
    opts = {
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        log_level = "error",
        auto_save_enabled = false,
        session_lens = {
            picker = "telescope",
            load_on_setup = true,
            mappings = {
                delete_session = { "i", "<C-d>" },
                alternate_session = { "i", "<C-s>" },
                copy_session = { "i", "<C-y>" },
            },
        }
    },
    lazy = false,
}
