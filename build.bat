@echo off

set operation=%1
set build_dir=build
set builder=latexmk
set options=-auxdir=%build_dir% -pdf

if "%operation%" == "watch" (
    latexmk -pvc %options%
) else if "%operation%" == "build" (
    latexmk %options%
) else if "%operation%" == "format" (
    fd . --type=f -e tex --exec latexindent --silent --local --cruft=%build_dir% --overwriteIfDifferent {}
)

