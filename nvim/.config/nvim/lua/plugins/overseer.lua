local function open_float(bufnr)
    local Popup = require("nui.popup")
    local event = require("nui.utils.autocmd").event

    local popup = Popup({
        enter = true,
        focusable = true,
        border = {
            style = "rounded",
        },
        position = "50%",
        size = {
            width = "90%",
            height = "90%",
        },
        bufnr = bufnr,
    })

    popup:mount()
    popup:on(event.BufLeave, function()
        popup:unmount()
    end)
end

return {
    "stevearc/overseer.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    keys = {
        { "<leader>oo", function() require("overseer").toggle() end, desc = "Toggle" },
        { "<leader>or", ":OverseerRun<CR>",                          desc = "Run" },
        { "<leader>oq", ":OverseerQuickAction<CR>",                  desc = "Quick Action" },
        {
            "<leader>of",
            function()
                local overseer = require("overseer")
                local task_list = require("overseer.task_list")
                local tasks = overseer.list_tasks({
                    status = {
                        overseer.STATUS.SUCCESS,
                        overseer.STATUS.FAILURE,
                        overseer.STATUS.CANCELED,
                        overseer.STATUS.RUNNING
                    },
                    sort = task_list.sort_newest_first
                })
                if vim.tbl_isempty(tasks) then
                    vim.notify("No tasks found", vim.log.levels.WARN)
                else
                    local most_recent = tasks[1]
                    open_float(most_recent:get_bufnr())
                end
            end,
            desc = "Open Float"
        },
    },
    opts = {
        templates = {
            -- "builtin",
            "user.cargo_build",
            "user.cargo_clean",
            "user.cargo_run",
            "user.cargo_test",
            "user.cmake_generate",
            "user.cmake_build",
            "user.cmake_clean",
            "user.cmake_test",
            "user.python_run"
        },
        task_win = {
            win_opts = { "border", "rounded" }
        }
    }
}
