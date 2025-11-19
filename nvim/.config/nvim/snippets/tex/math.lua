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


    s({ trig = "ali", wordTrig = true, snippetType = "autosnippet", condition = conds.line_begin },
        fmta(
            [[
      \begin{align*}
          <>
          <>%
      \end{align*}
    ]],
            {
                i(0),
                i(1, "."),
            }
        )
    ),

    s({ trig = "cases" },
        fmta(
            [[
      \begin{cases}
          <>
      \end{cases}
    ]],
            {
                i(0),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "matb" },
        fmta(
            [[
      \begin{bmatrix}
          <>
      \end{bmatrix}
    ]],
            {
                i(0),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "matp" },
        fmta(
            [[
      \begin{pmatrix}
          <>
      \end{pmatrix}
    ]],
            {
                i(0),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])array", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[
      <>\begin{array}{c}
          <>
      \end{array}
    ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(0),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = '([^%a])int', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\int_{<>}^{<>} <> d<> ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1, "-\\infty"),
                i(2, "\\infty"),
                i(4),
                i(3, "x"),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = '([^%a])prod', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\prod_{<>}^{<>} ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1, "-\\infty"),
                i(2, "\\infty"),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = '([^%a])sum', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\sum_{<>}^{<>} ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1, "n=0"),
                i(2, "N-1"),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = '([^%a])sqrt', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\sqrt{<>} ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = '([^%a])log', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\log_{<>} ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1, "2"),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = '([^%a])ln', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\ln ]],
            {
                f(function(_, snip) return snip.captures[1] end),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = '([^%a])ff', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\frac{<>}{<>} ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
                i(2)
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])mcal", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\mathcal{<>}]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])mbb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\mathbb{<>}]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])tt", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\text{<>}]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "$$", snippetType = "autosnippet" },
        fmta(
            [[$<>$]],
            {
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])bm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\bm{<>}]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "__", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[_{<>}]],
            {
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "^^", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[^{<>}]],
            {
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])oo", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\infty]],
            {
                f(function(_, snip) return snip.captures[1] end),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "((", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\mleft( <> \mright)]],
            {
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "[[", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            "\\mleft[ <> \\mright]",
            {
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "{{", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            "\\mleft\\{ <> \\mright\\}",
            {
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "||", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            "\\lvert <> \\rvert ",
            {
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])hat", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\hat{<>}]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])tld", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\tilde{<>}]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])bar", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\overline{<>}]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([%a])([%d])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>_<>]],
            {
                f(function(_, snip) return snip.captures[1] end),
                f(function(_, snip) return snip.captures[2] end),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "=>", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Rightarrow ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "->", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\rightarrow ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "([^%a])nab", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[<>\nabla ]],
            {
                f(function(_, snip) return snip.captures[1] end),
            }
        ),
        { condition = tex_utils.in_mathzone }
    ),
}
