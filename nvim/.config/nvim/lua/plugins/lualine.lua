return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    opts = {
        options = { theme = 'gruvbox_dark' },
        extensions = {
            'mason',
            'toggleterm'
        },
        sections = {
            lualine_c = {
                {
                    "filename",
                    path = 1,
                    shorting_target = 50,
                }
            },
            lualine_b = { 'branch' },
            lualine_x = { 'encoding' },
            lualine_y = {
                {
                    function()
                        local reg = vim.fn.reg_recording()
                        if reg ~= "" then
                            return "Recording @" .. reg
                        else
                            return ""
                        end
                    end,
                    color = { fg = "#fabd2f" }
                }
            }
        }
    }
}
