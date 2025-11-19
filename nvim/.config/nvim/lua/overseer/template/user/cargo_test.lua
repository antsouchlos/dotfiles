return {
    name = "Cargo Test",
    builder = function()
        return {
            cmd = { "cargo" },
            args = { "test", },
            components = {
                { "on_output_quickfix" },
                "default"
            }
        }
    end,
    condition = {
        filetype = { "rust", }
    }
}
