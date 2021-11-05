workspace "LearnOpenGL"
	architecture "x64"
	startproject "Tutorial"
	configurations { "Debug", "Release" }

	flags
	{
		"MultiProcessorCompile"
	}
-- This is a helper variable, to concatenate the sys-arch
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- outputbindir = "bin/%{prj.name}/%{cfg.system}-%{cfg.architecture}-%{cfg.buildcfg}"
-- outputobjdir = "bin-int/%{prj.name}/%{cfg.system}-%{cfg.architecture}-%{cfg.buildcfg}"

newaction {
    trigger = "clean",
    description = "Remove all binaries and intermediate binaries, and vs files.",
    execute = function()
        print("Removing binaries")
        os.rmdir("./bin")
        print("Removing intermediate binaries")
        os.rmdir("./bin-int")
        print("Removing project files")
        os.rmdir("./.vs")
        os.remove("**.sln")
        os.remove("**.vcxproj")
        os.remove("**.vcxproj.filters")
        os.remove("**.vcxproj.user")
        print("Done")
    end
}


project "Tutorial"
	location "Tutorial"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	-- systemversion "latest"

	targetdir("%{prj.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir("%{prj.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.location}/src/**.cpp",
		"%{prj.location}/src/**.h"
	}

	includedirs
	{
		"src",
		"%{wks.location}/vendor/glad/include",
		"%{wks.location}/vendor/glfw/include",
		"%{wks.location}/vendor/imgui",
		"%{wks.location}/vendor/glm",
		"%{wks.location}/vendor/spdlog/include"
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	links
	{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		defines "SPDLOG_WCHAR_TO_UTF8_SUPPORT"
        -- buildoptions { "-lgdi32" }
        systemversion "latest"
		defines  {
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS",
			"GLFW_INCLUDE_NONE"
        }

	filter "system:macosx"
		links
		{
			"CoreFoundation.framework",
			"Cocoa.framework",
			"IOKit.framework",
			"CoreVideo.framework"
		}

	filter "configurations:Debug"
		-- buildoptions "/MTd"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		-- buildoptions "/MT"
		runtime "Release"
		optimize "on"


group "Dependencies"

-- project "Glad"
-- 	location "vendor/glad"
-- 	kind "StaticLib"
-- 	language "C"
-- 	staticruntime "on"
-- 	systemversion "latest"

-- 	targetdir("bin/" .. outputdir .. "/%{prj.name}")
--     objdir("bin-int/" .. outputdir .. "/%{prj.name}")

-- 	files
-- 	{
-- 		"%{prj.location}/src/glad.c",
-- 		"%{prj.location}/include/**.h",
-- 	}

-- 	includedirs
-- 	{
-- 		"%{prj.location}/include"
-- 	}

-- 	filter "configurations:Debug"
-- 		runtime "Debug"
-- 		symbols "on"

-- 	filter "configurations:Release"
-- 		runtime "Release"
-- 		optimize "on"



project "Glad"
	location "vendor/glad"
	kind "StaticLib"
	language "C"
	staticruntime "on"
	
	targetdir ("%{prj.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{prj.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.location}/include/glad/glad.h",
		"%{prj.location}/include/KHR/khrplatform.h",
		"%{prj.location}/src/glad.c"
	}

	includedirs
	{
		"%{prj.location}/include"
	}
	
	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

-- project "GLFW"
-- 	location "vendor/glfw"
-- 	kind "StaticLib"
-- 	language "C"
-- 	staticruntime "on"
-- 	systemversion "latest"

-- 	targetdir("bin/" .. outputdir .. "/%{prj.name}")
--     objdir("bin-int/" .. outputdir .. "/%{prj.name}")

-- 	files
-- 	{
-- 		"%{prj.location}/src/context.c",
-- 		"%{prj.location}/src/egl_context.c",
-- 		"%{prj.location}/src/egl_context.h",
-- 		"%{prj.location}/src/init.c",
-- 		"%{prj.location}/src/input.c",
-- 		"%{prj.location}/src/internal.h",
-- 		"%{prj.location}/src/monitor.c",
-- 		"%{prj.location}/src/osmesa_context.c",
-- 		"%{prj.location}/src/osmesa_context.h",
-- 		"%{prj.location}/src/vulkan.c",
-- 		"%{prj.location}/src/window.c",
		

-- 		"%{prj.location}/src/glfw_config.h",
-- 		"%{prj.location}/include/GLFW/glfw3.h",
-- 		"%{prj.location}/include/GLFW/glfw3native.h"
-- 	}

-- 	filter "configurations:Debug"
-- 		runtime "Debug"
-- 		symbols "on"

-- 	filter "configurations:Release"
-- 		runtime "Release"
-- 		optimize "on"

-- 	filter "system:windows"
-- 		files
-- 		{
-- 			"%{prj.location}/src/wgl_context.c",
-- 			"%{prj.location}/src/wgl_context.h",
-- 			"%{prj.location}/src/win32_init.c",
-- 			"%{prj.location}/src/win32_joystick.c",
-- 			"%{prj.location}/src/win32_joystick.h",
-- 			"%{prj.location}/src/win32_monitor.c",
-- 			"%{prj.location}/src/win32_platform.h",
-- 			"%{prj.location}/src/win32_thread.c",
-- 			"%{prj.location}/src/win32_time.c",
-- 			"%{prj.location}/src/win32_window.c"
-- 		}

-- 		defines 
-- 		{ 
-- 			"_GLFW_WIN32",
-- 			"_CRT_SECURE_NO_WARNINGS"
-- 		}
	
-- 	filter "system:linux"
-- 		files
-- 		{
-- 			"%{prj.location}/src/glx_context.c",
-- 			"%{prj.location}/src/glx_context.h",
-- 			"%{prj.location}/src/linux_joystick.c",
-- 			"%{prj.location}/src/linux_joystick.h",
-- 			"%{prj.location}/src/posix_time.c",
-- 			"%{prj.location}/src/posix_time.h",
-- 			"%{prj.location}/src/posix_thread.c",
-- 			"%{prj.location}/src/posix_thread.h",
-- 			"%{prj.location}/src/x11_init.c",
-- 			"%{prj.location}/src/x11_monitor.c",
-- 			"%{prj.location}/src/x11_platform.h",
-- 			"%{prj.location}/src/x11_window.c",
-- 			"%{prj.location}/src/xkb_unicode.c",
-- 			"%{prj.location}/src/xkb_unicode.h"
-- 		}

-- 		defines 
-- 		{ 
-- 			"_GLFW_X11"
-- 		}
		
-- 	filter "system:macosx"
-- 		files
-- 		{
-- 			"%{prj.location}/src/cocoa_init.m",
-- 			"%{prj.location}/src/cocoa_joystick.m",
-- 			"%{prj.location}/src/cocoa_joystick.h",
-- 			"%{prj.location}/src/cocoa_monitor.m",
-- 			"%{prj.location}/src/cocoa_platform.h",
-- 			"%{prj.location}/src/cocoa_time.c",
-- 			"%{prj.location}/src/cocoa_window.m",
-- 			"%{prj.location}/src/nsgl_context.m",
-- 			"%{prj.location}/src/nsgl_context.h",
-- 			"%{prj.location}/src/posix_thread.c",
-- 			"%{prj.location}/src/posix_thread.h"
-- 		}

-- 		defines
-- 		{ 
-- 			"_GLFW_COCOA"
-- 		}

project "ImGui"
	kind "StaticLib"
	language "C++"
	location "vendor/imgui"
	staticruntime "on"
	systemversion "latest"

	targetdir ("%{prj.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{prj.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.location}/imconfig.h",
		"%{prj.location}/imgui.h",
		"%{prj.location}/imgui.cpp",
		"%{prj.location}/imgui_draw.cpp",
		"%{prj.location}/imgui_internal.h",
		"%{prj.location}/imgui_widgets.cpp",
		"%{prj.location}/imstb_rectpack.h",
		"%{prj.location}/imstb_textedit.h",
		"%{prj.location}/imstb_truetype.h",
		"%{prj.location}/imgui_demo.cpp"
	}

	filter "system:windows"
		systemversion "latest"
		cppdialect "C++17"
		staticruntime "On"

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++17"
		staticruntime "On"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"



project "GLFW"
		kind "StaticLib"
		language "C"
		location "vendor/glfw"
		targetdir ("%{prj.location}/bin/" .. outputdir .. "/%{prj.name}")
		objdir ("%{prj.location}/bin-int/" .. outputdir .. "/%{prj.name}")
	
		files
		{
			"%{prj.location}/include/GLFW/glfw3.h",
			"%{prj.location}/include/GLFW/glfw3native.h",
			"%{prj.location}/src/glfw_config.h",
			"%{prj.location}/src/internal.h",
			"%{prj.location}/src/context.c",
			"%{prj.location}/src/init.c",
			"%{prj.location}/src/input.c",
			"%{prj.location}/src/monitor.c",
			"%{prj.location}/src/vulkan.c",
			"%{prj.location}/src/window.c"
		}
		filter "system:linux"
			pic "On"
	
			systemversion "latest"
			staticruntime "On"
	
			files
			{
				"%{prj.location}/src/x11_init.c",
				"%{prj.location}/src/x11_monitor.c",
				"%{prj.location}/src/x11_window.c",
				"%{prj.location}/src/xkb_unicode.c",
				"%{prj.location}/src/posix_time.c",
				"%{prj.location}/src/posix_thread.c",
				"%{prj.location}/src/glx_context.c",
				"%{prj.location}/src/egl_context.c",
				"%{prj.location}/src/osmesa_context.c",
				"%{prj.location}/src/linux_joystick.c"
			}
	
			defines
			{
				"_GLFW_X11"
			}
	
		filter "system:windows"
			systemversion "latest"
			staticruntime "On"
	
			files
			{
				"%{prj.location}/src/win32_init.c",
				"%{prj.location}/src/win32_joystick.c",
				"%{prj.location}/src/win32_monitor.c",
				"%{prj.location}/src/win32_time.c",
				"%{prj.location}/src/win32_thread.c",
				"%{prj.location}/src/win32_window.c",
				"%{prj.location}/src/wgl_context.c",
				"%{prj.location}/src/egl_context.c",
				"%{prj.location}/src/osmesa_context.c"
			}
	
			defines 
			{ 
				"_GLFW_WIN32",
				"_CRT_SECURE_NO_WARNINGS"
			}
	
		filter "configurations:Debug"
			runtime "Debug"
			symbols "on"
	
		filter "configurations:Release"
			runtime "Release"
			optimize "on"
