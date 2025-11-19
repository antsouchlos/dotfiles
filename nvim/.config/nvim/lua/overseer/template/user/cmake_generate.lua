return {
    name = "CMake Generate",
    params = {
        build_type = {
            type = "enum",
            choices = {
                "Debug",
                "Release",
                "RelWithDebInfo",
                "MinSizeRel"
            },
            default = "Release"
        },
        generator = {
            type = "enum",
            choices = {
                "Ninja",
                "Unix Makefiles"
            },
            default = "Ninja"
        },
        compiler = {
            type = "enum",
            choices = {
                "g++",
                "clang++"
            },
            default = "g++"
        }
    },
    builder = function(params)
        return {
            cmd = { "cmake" },
            args = {
                "-B",
                "build",
                "-S",
                ".",
                "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
                "-DCMAKE_BUILD_TYPE=" .. params.build_type,
                "-DCMAKE_CXX_COMPILER=" .. params.compiler,
                "-G",
                params.generator
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
