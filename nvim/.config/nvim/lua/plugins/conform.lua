return {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    keys = {
        {
            '<M-L>',
            function()
                require('conform').format()
            end,
            mode = { 'n', 'i' },
            desc = 'Format',
        },
    },
    opts = {
        default_format_opts = {
            lsp_format = 'fallback',
            stop_after_first = true,
        },
        formatters_by_ft = {
            c = { 'clang_format' },
            cpp = { 'clang_format' },
            javascript = { 'deno_fmt' },
            javascriptreact = { 'deno_fmt' },
            lua = { 'lua-format' },
            markdown = { 'mdformat' },
            nix = { 'nixfmt' },
            python = { 'ruff_format' },
            rust = { 'rustfmt' },
            sh = { 'shfmt' },
            tex = { 'tex-fmt' },
            typescript = { 'deno_fmt' },
            typescriptreact = { 'deno_fmt' },
            typst = { 'typstyle' },
            zsh = { 'shfmt' },
        },
    },
}
