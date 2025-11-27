--
--
-- LSP configs
--
--


vim.lsp.config("texlab", {
    settings = {
        texlab = {
            rootDirectory = nil,
            build = {
                executable = 'latexmk',
                args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                onSave = false,
                forwardSearchAfter = false,
            },
            forwardSearch = {
                executable = nil,
                args = {},
            },
            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },
            diagnosticsDelay = 300,
            latexFormatter = 'tex-fmt',
            bibtexFormatter = 'tex-fmt',
        },
    },

})

vim.lsp.config('clangd', {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=bundled",
        "--cross-file-rename",
        "--header-insertion=iwyu",
        -- Required for embedded system compilers
        "--query-driver=/**/*g++",
        "--offset-encoding=utf-16"
        -- "-j=8",
        -- "--malloc-trim",
        -- "--pch-storage=memory"
    }
})


--
--
-- Diagnostics config
--
--


vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local width = vim.api.nvim_win_get_width(0);

        vim.diagnostic.open_float(nil, {
            scope = "cursor",
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            source = true,
            relative = "editor",
            width = 40,
            focusable = false,
            focused = false,
            border = "rounded",
            title = "Diagnostics",
            header = "",
            title_pos = "center",
            offset_x = width,
            offset_y = -1,
        })
    end,
})


--
--
-- Keymaps
--
--


vim.o.completeopt = "menu,menuone,noinsert,fuzzy"

vim.api.nvim_set_keymap("i", "<C-Space>", "<C-x><C-o>", { noremap = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        vim.keymap.set('n', '<M-L>', function() vim.lsp.buf.format() end,
            { desc = "Format", noremap = true, silent = true })
        vim.keymap.set('i', '<M-L>', function() vim.lsp.buf.format() end,
            { desc = "Format", noremap = true, silent = true })
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
            { desc = "Go to definition" })
    end,
})
