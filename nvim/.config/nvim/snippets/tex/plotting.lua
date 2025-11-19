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


    s({ trig = "funcplot" },
        fmta(
            [[
      \begin{figure}[H]
          \centering

          \begin{tikzpicture}
              \begin{axis}[
                  domain=<>,
                  width=\textwidth,
                  height=0.75\textwidth,
              ]
                  \addplot+[mark=none, line width=1pt]
                      {<>};
              \end{axis}
          \end{tikzpicture}
      \end{figure}
    ]],
            {
                i(1, "-5:5"),
                i(2),
            }
        )
    ),

    s({ trig = "csvplot" },
        fmta(
            [[
      \begin{figure}[H]
          \centering

          \begin{tikzpicture}
              \begin{axis}[
                  width=\textwidth,
                  height=0.75\textwidth,
              ]
                  \addplot+[mark=none, line width=1pt]
                      table[col sep=comma, x=<>, y=<>]
                          {<>};
              \end{axis}
          \end{tikzpicture}
      \end{figure}
    ]],
            {
                i(1, "x"),
                i(2, "y"),
                i(3),
            }
        )
    ),

    s({ trig = "fig" },
        fmta(
            [[
      \begin{figure}[H]
          \centering

          <>

          \caption{<>}
          \label{fig:<>}
      \end{figure}
    ]],
            {
                i(0),
                i(1),
                i(2),
            }
        )
    ),
}
