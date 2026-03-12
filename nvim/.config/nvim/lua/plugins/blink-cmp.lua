return {
    'saghen/blink.cmp',
    version = '1.*',
    event = "InsertEnter",
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    opts = {
        keymap = {
            ['<Tab>'] = { 'select_and_accept', 'fallback' },
        },
        snippets = { preset = 'luasnip' },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
    }
}
