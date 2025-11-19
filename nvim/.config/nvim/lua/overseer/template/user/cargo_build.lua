return {
    name = "Cargo Build",
    builder = function()
        return {
            cmd = { "cargo" },
            args = { "build" },
            components = {
                { "on_output_quickfix" },
                "default"
            }
        }
    end,
    condition = {
        filetype = { "rust" }
    }
}
