-- Description: Build system for the codebase.
-- Author: Luiz G. Mugnaini A. <luizmugnaini@gmail.com>
--
-- Running the build system:  lua build.lua [options]
-- Examples:
-- * Single build:
--   lua build.lua build deepdive
-- * Continuous build:
--   lua build.lua watch deepdive

local start_time = os.clock()

-- Available command line options.
local opts = {
    clean = false,
    build = false,
    watch = false,
    -- Build the deep-dive target.
    deepdive = false,
    -- Build masters thesis.
    masters = false,
}

for i = 1, #arg do
    opts[arg[i]] = true
end

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

function exec(cmd_str)
    print("\x1b[1;35mexecuting ::\x1b[0m " .. cmd_str)
    os.execute(cmd_str)
end

local build_dir = "build"
local config = {
    deep_dive_main = "deep-dive.tex",
    masters_main = "masters.tex",
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
    os.remove(build_dir)
end
if opts.deepdive then
    run_builder(config.deep_dive_main)
end
if opts.masters then
    run_builder(config.masters_main)
end
if not opts.quiet then
    print(string.format("\x1b[1;35mtime elapsed ::\x1b[0m %.5f seconds", os.clock() - start_time))
end
