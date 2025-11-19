return {
    name = "CMake Build",
    builder = function()
        return {
            cmd = { "cmake" },
            args = {
                "--build",
                "build",
                "-j16"
            },
            components = {
                { "on_output_quickfix" },
                "default"
            }
        }
    end,
    condition = {
        filetype = {
            "cmake",
            "cpp"
        }
    }
}
