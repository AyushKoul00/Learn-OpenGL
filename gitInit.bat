@echo off
git init

git submodule add https://github.com/g-truc/glm.git vendor/glm

git submodule add https://github.com/glfw/glfw.git vendor/glfw

git submodule add https://github.com/gabime/spdlog.git vendor/spdlog

git submodule add https://github.com/ocornut/imgui.git vendor/imgui

