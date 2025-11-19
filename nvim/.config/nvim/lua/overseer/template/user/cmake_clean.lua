return {
    name = "CMake Clean",
    builder = function()
        return {
            cmd = { "rm" },
            args = {
                "-r",
                "build",
            },
            components = { "default" }
        }
    end,
    condition = {
        filetype = {
            "cmake",
            "cpp"
        }
    }
}
