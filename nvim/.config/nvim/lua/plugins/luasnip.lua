return {
    "https://github.com/rafamadriz/friendly-snippets",
    dependencies = { "https://github.com/L3MON4D3/LuaSnip" },
    event = "InsertEnter",
    config = function()
        local loader = require("luasnip.loaders.from_lua")
        loader.lazy_load({ paths = { "./snippets" } })

        require("luasnip").config.set_config({
            enable_autosnippets = true,
            store_selection_keys = "<leader>v"
        })

        vim.keymap.set({ "i", "s" }, "<c-j>", function() require("luasnip").jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<c-k>", function() require("luasnip").jump(-1) end, { silent = true })
    end
}
