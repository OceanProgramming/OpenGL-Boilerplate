workspace "OpenGLBoilerplate"
	architecture "x64"
	startproject "Program"

	flags { "MultiProcessorCompile" }
	
	configurations { "Debug", "Release" }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDirectories = {}
IncludeDirectories["glfw"] = "%{wks.location}/vendor/glfw/include"
IncludeDirectories["glad"] = "%{wks.location}/vendor/glad/include"

project "Program"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	
	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")
	
	files
	{
		"src/*.h",
		"src/*.cpp"
	}
	
	includedirs
	{
		"src",
        "%{IncludeDirectories.glfw}",
        "%{IncludeDirectories.glad}"
	}

    links
    {
        "glfw",
        "glad"
    }
	
	filter "system:windows"
		systemversion "latest"
	
	filter "system:macosx"
		defines { "PLATFORM_MACOS" }
	
	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "Speed"

-- Dependencies --
include "vendor/glad"
include "vendor/glfw"