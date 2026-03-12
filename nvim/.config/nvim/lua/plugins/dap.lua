return {
    {
        'mfussenegger/nvim-dap',
        keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<cr>",                   desc = "Toggle breakpoint" },
            { "<leader>dc", "<cmd>DapContinue<cr>",                           desc = "Continue" },
            { "<leader>dt", "<cmd>DapTerminate<cr>",                          desc = "Terminate" },
            { "<leader>di", "<cmd>DapStepInto<cr>",                           desc = "Step into" },
            { "<leader>dn", "<cmd>DapStepOver<cr>",                           desc = "Step over" },
            { "<leader>do", "<cmd>DapStepOut<cr>",                            desc = "Step out" },
            { '<Leader>dh', function() require('dap.ui.widgets').hover() end, desc = "Hover" },
        },
        config = function()
            local dap = require("dap")

            -- Adapters

            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
            }

            dap.adapters["rust-gdb"] = {
                type = "executable",
                command = "rust-gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
            }

            dap.adapters.python = function(cb, config)
                if config.request == 'attach' then
                    local port = (config.connect or config).port
                    local host = (config.connect or config).host or '127.0.0.1'
                    cb({
                        type = 'server',
                        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                        host = host,
                        options = {
                            source_filetype = 'python'
                        }
                    })
                else
                    cb({
                        type = 'executable',
                        command = 'python',
                        args = {
                            '-m',
                            'debugpy.adapter'
                        },
                        options = {
                            source_filetype = 'python'
                        }
                    })
                end
            end

            -- Configurations

            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    args = {}, -- provide arguments if needed
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
                {
                    name = "Select and attach to process",
                    type = "gdb",
                    request = "attach",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    pid = function()
                        local name = vim.fn.input('Executable name (filter): ')
                        return require("dap.utils").pick_process({ filter = name })
                    end,
                    cwd = '${workspaceFolder}'
                },
                {
                    name = 'Attach to gdbserver :1234',
                    type = 'gdb',
                    request = 'attach',
                    target = 'localhost:1234',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}'
                }
            }

            dap.configurations.cpp = dap.configurations.c

            dap.configurations.rust = {
                {
                    name = "Launch",
                    type = "rust-gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    args = {},
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
                {
                    name = "Select and attach to process",
                    type = "rust-gdb",
                    request = "attach",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    pid = function()
                        local name = vim.fn.input('Executable name (filter): ')
                        return require("dap.utils").pick_process({ filter = name })
                    end,
                    cwd = "${workspaceFolder}"
                },
                {
                    name = "Attach to gdbserver :1234",
                    type = "rust-gdb",
                    request = "attach",
                    target = "localhost:1234",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}'
                }
            }

            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",

                    program = "${file}",
                    pythonPath = function()
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                            return cwd .. '/venv/bin/python'
                        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                            return cwd .. '/.venv/bin/python'
                        else
                            return '/usr/bin/python'
                        end
                    end
                }
            }
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        keys = { { "<leader>du", function() require("dapui").toggle() end, desc = " Toggle UI" } },
        config = function()
            require("dapui").setup({
                controls = { enabled = false },
                layouts = {
                    {
                        elements = {
                            { id = "scopes",      size = 0.33 },
                            { id = "breakpoints", size = 0.33 },
                            { id = "stacks",      size = 0.33 }
                        },
                        position = "left",
                        size = 60
                    },
                    {
                        elements = { { id = "repl", size = 1 } },
                        position = "bottom",
                        size = 15
                    }
                }
            })
        end
    }
}
