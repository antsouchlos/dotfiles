--
--
-- Helper functions
--
--

local function get_random_image()
    local images = {
        {
            [[██╗      █████╗  ██████╗██╗  ██╗███████╗]],
            [[██║     ██╔══██╗██╔════╝██║  ██║██╔════╝]],
            [[██║     ███████║██║     ███████║███████╗]],
            [[██║     ██╔══██║██║     ██╔══██║╚════██║]],
            [[███████╗██║  ██║╚██████╗██║  ██║███████║]],
            [[╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝]]
        },
        {
            [[                       ,,,╓▄▄▓▓▓▓▄                    ,▄▓∩]],
            [[         ,╓▄▄▄▄▓▓▓▓▓▓▓▓▀▓▓▓▓▓▓▓▓▓▀▀▀▓@@æ▄╓,▄▄      ,▄▓▓▓▓ ]],
            [[  ,▄▄▓▓█████▀╫╫Ñ▒Ñ▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▀▀▀▓@#▓▓▀▓▓▓Ñ ]],
            [[  -2▓╫▒▒▒▒▒╫▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓  ]],
            [[    ª╨╩Ñ▒▒▒▒▒╫▄▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒░▒░░░░░░░═╨`     `╫╫▓▓▓▓ ]],
            [[          `ªº╩▒▒▒▒░░░░...░░▒▒▒▄▒▒▒ºª``              `▀▓▓▓ ]],
            [[                                                      ╙▓µ ]]
        },
        {
            [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
            [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
            [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
            [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
            [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
            [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]
        },
        {
            [[                  ▄                  ]],
            [[                 ▟█▙                 ]],
            [[                ▟███▙                ]],
            [[               ▟█████▙               ]],
            [[              ▟███████▙              ]],
            [[             ▂▔▀▜██████▙             ]],
            [[            ▟██▅▂▝▜█████▙            ]],
            [[           ▟█████████████▙           ]],
            [[          ▟███████████████▙          ]],
            [[         ▟█████████████████▙         ]],
            [[        ▟███████████████████▙        ]],
            [[       ▟█████████▛▀▀▜████████▙       ]],
            [[      ▟████████▛      ▜███████▙      ]],
            [[     ▟█████████        ████████▙     ]],
            [[    ▟██████████        █████▆▅▄▃▂    ]],
            [[   ▟██████████▛        ▜█████████▙   ]],
            [[  ▟██████▀▀▀              ▀▀██████▙  ]],
            [[ ▟███▀▘                       ▝▀███▙ ]],
            [[▟▛▀                               ▀▜▙]],
            [[                 btw                 ]]
        }
    }

    local pmf = { 0.25, 0.25, 0.25, 0.25 }
    local cdf = {}

    cdf[1] = 0
    for j = 2, #pmf + 1 do
        cdf[j] = cdf[j - 1] + pmf[j - 1]
    end

    if math.abs(cdf[#cdf] - 1) > 0.01 then
        error("Probabilities do not add up to 1")
    elseif #images ~= #pmf then
        error("Number of images and probabilities do not match")
    end

    math.randomseed(os.time())
    local r = math.random(100)

    for j = 2, #cdf do
        if r <= cdf[j] * 100 then
            return images[j - 1]
        end
    end
end

--
--
-- Plugin configuration
--
--

return {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = get_random_image()
        dashboard.section.buttons.val = {
            dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
            dashboard.button('r', '  Recent files', ':Telescope oldfiles <CR>'),
            dashboard.button('f', '󰥨  Find file', ':Telescope find_files <CR>'),
            dashboard.button('g', '󰱼  Find text', ':Telescope live_grep <CR>'),
            dashboard.button('p', '  Open project', ':Telescope session-lens search_session<CR>'),
            dashboard.button('l', '󰒲  Lazy', ':Lazy<CR>'),
            dashboard.button('q', '  Quit', ':qa<CR>')
        }

        require("alpha").setup(dashboard.opts)
    end
}
