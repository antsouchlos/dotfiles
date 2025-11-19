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


    s({ trig = "´a", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\alpha ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´b", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\beta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´g", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\gamma ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´d", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\delta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´e", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\epsilon ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´z", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\zeta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´h", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\eta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´q", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\theta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´i", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\iota ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´k", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\kappa ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´l", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\lambda ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´m", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\mu ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´n", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\nu ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´x", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\xi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´p", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\pi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´r", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\rho ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´s", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\sigma ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´t", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\tau ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´u", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\upsilon ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´f", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\phi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´c", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\chi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´y", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\psi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´w", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\omega ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´A", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Alpha ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´B", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Beta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´G", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Gamma ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´D", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Delta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´E", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Epsilon ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´Z", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Zeta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´H", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Eta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´Q", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Theta ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´I", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Iota ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´K", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Kappa ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´L", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Lambda ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´M", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Mu ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´N", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Nu ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´X", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Xi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´P", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Pi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´R", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Rho ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´S", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Sigma ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´T", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Tau ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´U", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Upsilon ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´F", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Phi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´C", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Chi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´Y", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Psi ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = "´W", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\Omega ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),


    -- Strictly speaking not greek characters, but very similar snippets

    s({ trig = "´6", wordTrig = false, snippetType = "autosnippet" },
        fmta(
            [[\partial ]],
            {}
        ),
        { condition = tex_utils.in_mathzone }
    ),

}
