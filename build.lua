-- Description: Build system for the codebase.
-- Author: Luiz G. Mugnaini A. <luizmugnaini@gmail.com>
--
-- Running the build system:  lua build.lua [options]
-- Examples:
-- * Single build:
--   lua build.lua build
-- * Continuous build:
--   lua build.lua watch

local start_time = os.time()

-- Available command line options.
local opts = {
    clean = false, -- Clean previous build directory.
    build = false, -- Perform a single build.
    watch = false, -- Continuously build the project, watching for changes.
}

for i = 1, #arg do
    opts[arg[i]] = true
end

local os_windows = (package.config:sub(1, 1) == "\\")
local os_info = { path_sep = os_windows and "\\" or "/" }

function concat(arr)
    if #arr < 1 then
        return ""
    end

    local acc = arr[1]
    for i = 2, #arr do
        acc = acc .. " " .. arr[i]
    end
    return acc
end

function log_info(msg)
    print("\x1b[1;35m[INFO]\x1b[0m " .. msg)
end

function log_error(msg)
    print("\x1b[1;31m[ERROR]\x1b[0m " .. msg)
end

function exec(cmd_str)
    log_info("executing: " .. cmd_str)
    os.execute(cmd_str)
end

function concat(arr, join, is_prefix)
    if not join then
        join = " "
    end

    if arr == nil or #arr < 1 then
        return ""
    end

    local acc = nil
    if is_prefix then
        acc = join .. arr[1]
    else
        acc = arr[1]
    end

    for i = 2, #arr do
        acc = acc .. join .. arr[i]
    end

    return acc
end

function make_path(arr)
    return concat(arr, os_info.path_sep, false)
end

function get_script_dir()
    local info = debug.getinfo(1, "S").source:sub(2)
    return info:match("(.*)[/\\]")
end

local root_dir = get_script_dir()
if not root_dir then
    root_dir = "."
end

local build_dir = make_path({ root_dir, "build" })
local config = {
    main = make_path({ root_dir, "src", "deep-dive.tex" }),
    builder = "latexmk",
    builder_watch_opt = "-pvc",
    builder_opts = { "-pdf", "-auxdir=" .. build_dir },
}

function run_builder(main_file)
    if opts.watch then
        exec(concat({ config.builder, concat(config.builder_opts), config.builder_watch_opt, main_file }))
    elseif opts.build then
        exec(concat({ config.builder, concat(config.builder_opts), main_file }))
    end
end

if opts.clean then
    log_info("clearing build directory " .. build_dir)
    local status = os.remove(build_dir)
    if not status then
        log_error("failed to delete " .. build_dir .. ", resources may be locked")
    end
end

run_builder(config.main)

if not opts.quiet then
    log_info(string.format("time elapsed: %.5f seconds", os.time() - start_time))
end
