return {
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            processor = "magick_cli",
            backend = "kitty",                        -- Kitty will provide the best experience, but you need a compatible terminal
            integrations = {},                        -- do whatever you want with image.nvim's integrations
            max_width = 100,                          -- tweak to preference
            max_height = 12,                          -- ^
            max_height_window_percentage = math.huge, -- this is necessary for a good experience
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        }
    },
    { -- Use LSP in markdown files
        "quarto-dev/quarto-nvim",
        dependencies = { "jmbuhr/otter.nvim", "nvim-treesitter/nvim-treesitter" },
        ft = { "quarto", "markdown" },
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'markdown',
                callback = function()
                    require("quarto").activate()
                end
            })

            -- local runner = require("quarto.runner")
            -- vim.keymap.set("n", "<localleader>rc", runner.run_cell, {
            --     desc = "run cell",
            --     silent = true
            -- })
            -- vim.keymap.set("n", "<localleader>ra", runner.run_above, {
            --     desc = "run cell and above",
            --     silent = true
            -- })
            -- vim.keymap.set("n", "<localleader>rA", runner.run_all, {
            --     desc = "run all cells",
            --     silent = true
            -- })
            -- vim.keymap.set("n", "<localleader>rl", runner.run_line, {
            --     desc = "run line",
            --     silent = true
            -- })
            -- vim.keymap.set("v", "<localleader>r", runner.run_range, {
            --     desc = "run visual range",
            --     silent = true
            -- })
            -- vim.keymap.set("n", "<localleader>RA", function() runner.run_all(true) end, {
            --     desc = "run all cells of all languages",
            --     silent = true
            -- })
        end,
        opts = {
            lspFeatures = {
                languages = { "r", "python", "rust", "julia" },
                chunks = "all",
                diagnostics = { enabled = true, triggers = { "BufWritePost" } },
                completion = { enabled = true }
            },
            codeRunner = { enabled = true, default_method = "molten" }
        }
    },
    { -- Convert ipynb to markdown and back
        "GCBallesteros/jupytext.nvim",
        lazy = false,
        opts = {
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown"
        }
    },
    {                       -- Interactive code evaluation
        "benlubas/molten-nvim",
        version = "^1.9.2", -- use version <2.0.0 to avoid breaking changes
        build = ":UpdateRemotePlugins",
        ft = { "python", "markdown" },
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_auto_open_output = true
            -- vim.g.molten_virt_text_output = true
            vim.g.molten_virt_text_max_lines = 32
        end,
        config = function()
            vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",
                { silent = true, desc = "Initialize the plugin" })
            vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>",
                { silent = true, desc = "run operator selection" })
            vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
                { silent = true, desc = "evaluate line" })
            vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
                { silent = true, desc = "re-evaluate cell" })
            vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
                { silent = true, desc = "evaluate visual selection" })
        end
    }
}
