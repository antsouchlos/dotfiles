return {
    "lervag/vimtex",
    lazy = false, -- For backward search to work, :VimtexInverseSearch must always be available
    config = function()
        -- General configuration

        vim.cmd("syntax enable")

        vim.g.vimtex_compiler_latexmk = {
            out_dir = 'build',
            options = {
                '-shell-escape',
                '-verbose',
                '-file-line-error',
                '-interaction=nonstopmode',
                '-synctex=1'
            }
        }

        vim.g.vimtex_view_method = 'zathura_simple'
        vim.g.vimtex_quickfix_mode = 0
        vim.g.latex_flavor = 'latex'

        -- Concealment

        vim.o.conceallevel = 1

        vim.g.vimtex_syntax_conceal = {
            accents         = 1,
            ligatures       = 1,
            cites           = 1,
            fancy           = 1,
            spacing         = 0,
            greek           = 1,
            math_bounds     = 1,
            math_delimiters = 1,
            math_fracs      = 1,
            math_super_sub  = 0,
            math_symbols    = 1,
            sections        = 0,
            styles          = 0,
        }

        vim.g.vimtex_syntax_custom_cmds = {
            { name = 'bm', mathmode = 1, argstyle = 'bold', conceal = 1 },
        }
    end
}
