return {
    "rmagatti/auto-session",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ibhagwan/fzf-lua",
        "nvim-lualine/lualine.nvim"
    },
    init = function()
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    keys = {
        { '<leader>ss', '<cmd>AutoSession save<CR>',   desc = "Save" },
        { '<leader>sd', '<cmd>AutoSession delete<CR>', desc = "Delete" },
        { '<leader>fs', '<cmd>AutoSession search<CR>', desc = "Session" }
    },
    opts = {
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        log_level = "error",
        auto_save_enabled = false,
        session_lens = {
            picker = "fzf",
            -- load_on_setup = true,
            mappings = {
                delete_session = { "i", "<C-d>" },
                alternate_session = { "i", "<C-s>" },
                copy_session = { "i", "<C-y>" },
            },
        }
    },
    lazy = false,
}
