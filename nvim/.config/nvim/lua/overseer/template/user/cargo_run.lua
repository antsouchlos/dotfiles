return {
    name = "Cargo Run",
    builder = function()
        return {
            cmd = { "cargo" },
            args = { "run" },
            components = { "default" }
        }
    end,
    condition = {
        filetype = { "rust" }
    }
}
