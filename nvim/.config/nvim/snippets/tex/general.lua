----------------
-- Abbreviations
----------------


local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local conds = require("luasnip.extras.expand_conditions")

---------------
-- Environments
---------------


local tex_utils = {}

tex_utils.in_mathzone = function() -- math context detection
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

tex_utils.in_text = function()
    return not tex_utils.in_mathzone()
end

tex_utils.in_comment = function() -- comment detection
    return vim.fn['vimtex#syntax#in_comment']() == 1
end

tex_utils.in_env = function(name) -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

local get_visual = function(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1))
    end
end


-----------
-- Snippets
-----------


return {


    s({ trig = "notes" },
        fmta(
            [[
        \documentclass[dvipsnames]{article}

        \usepackage{float}
        \usepackage{amsmath}
        \usepackage{amsfonts}
        \usepackage{mleftright}
        \usepackage{bm}
        \usepackage{tikz}
        \usepackage{xcolor}
        \usepackage{pgfplots}
        \pgfplotsset{compat=newest}

        \title{<>}
        \author{<>}
        \date{<>}

        \begin{document}
            \maketitle

            <>
        \end{document}
      ]],
            {
                i(1, "Notes"),
                i(2, "Andreas Tsouchlos"),
                i(3, os.date("%d.%m.%y")),
                i(0),
            }
        )
    ),

    s({ trig = "beg", wordTrig = true, snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
      \begin{<>}
          <>
      \end{<>}
    ]],
            {
                i(1),
                i(2),
                rep(1),
            }
        )
    ),

    s({
            trig = "item",
            wordTrig = true,
            snippetType = "autosnippet",
            condition = function(line_to_cursor, matched_trigger, captures)
                return tex_utils.in_env("itemize") and conds.line_begin(line_to_cursor, matched_trigger, captures)
            end
        },
        fmta(
            [[
      \item <>
    ]],
            {
                i(0),
            }
        )
    ),

    s({ trig = "item", wordTrig = true, snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
      \begin{itemize}
          \item <>
      \end{itemize}
    ]],
            {
                i(0),
            }
        )
    ),

    s({ trig = "frame", wordTrig = true, snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
      \begin{frame}
          \frametitle{<>}
      \end{frame}
    ]],
            {
                i(0),
            }
        )
    ),

    s({ trig = "sec" },
        fmta(
            [[
      \section{<>}
      \label{sec:<>}
    ]],
            {
                i(1),
                rep(1),
            }
        )
    ),

    s({ trig = "ssec" },
        fmta(
            [[
      \subsection{<>}
      \label{subsec:<>}
    ]],
            {
                i(1),
                rep(1),
            }
        )
    ),

    s({ trig = "sssec" },
        fmta(
            [[
      \subsubsection{<>}
      \label{subsubsec:<>}
    ]],
            {
                i(1),
                rep(1),
            }
        )
    ),

    s({ trig = "csec" },
        fmta(
            [[
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            \section{<>}
            \label{sec:<>}
        ]],
            {
                i(1),
                rep(1),
            }
        )
    ),

    s({ trig = "cssec" },
        fmta(
            [[
            %%%%%%%%%%%%%%%%
            \subsection{<>}
            \label{subsec:<>}
        ]],
            {
                i(1),
                rep(1),
            }
        )
    ),

    s({ trig = "csssec" },
        fmta(
            [[
            %%%%%%%%
            \subsubsection{<>}
            \label{subsubsec:<>}
        ]],
            {
                i(1),
                rep(1),
            }
        )
    ),
}
