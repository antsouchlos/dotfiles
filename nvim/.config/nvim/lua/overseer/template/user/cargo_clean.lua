return {
    name = "Cargo Clean",
    builder = function()
        return {
            cmd = { "cargo" },
            args = { "clean" },
            components = { "default" }
        }
    end,
    condition = {
        filetype = { "rust" }
    }
}
