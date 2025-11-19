return {
    name = "CMake Test",
    builder = function()
        return {
            cmd = { "ctest" },
            args = {
                "--test-dir",
                "build",
                "--output-on-failure",
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
