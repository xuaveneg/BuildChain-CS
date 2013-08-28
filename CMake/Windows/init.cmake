# Windows Main File
cmake_minimum_required(VERSION 2.6.3)

set(RETURN_CODE 0)
### Target Platorm Informations
set(CMAKE_SYSTEM_NAME "Windows")
set(CMAKE_SYSTEM_VERSION 1)
# Windows Architecture
FindValidParameter(TARGET_ARCHITECTURE "${WINDOWS_ARCHITECTURE_LIST}" _FOUND "Windows Architecture")
if(NOT _FOUND)
	set(RETURN_CODE 113)
	message(SEND_ERROR
		"Please set a valid Architecture for Windows.\nValids Architectures are ${WINDOWS_ARCHITECTURE_LIST}.")
else()
	set(CMAKE_SYSTEM_PROCESSOR "${TARGET_ARCHITECTURE}")
endif(NOT _FOUND)
	

### The remaining configuration depends if we're cross-compiling or not
if ("${CMAKE_GENERATOR}" MATCHES "Visual Studio*")
	### Keep default configuration (no cross-compilation)
	# Should be used only to create vcxproj files (otherwise the build-type contained in the output path won't be ok)
	# MSVC Compiler (Even with native compiler, avoid try-compile because of caching issues and to avoid a loss of time)
	set(CMAKE_C_COMPILER_ID MSVC)
	set(CMAKE_CXX_COMPILER_ID MSVC)
	set(CMAKE_C_COMPILER_WORKS TRUE CACHE INTERNAL "")
	set(CMAKE_CXX_COMPILER_WORKS TRUE CACHE INTERNAL "")
	
	### Project Paths
	# Configuration (CMAKE_BUILD_TYPE) is automatically put at the end
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/Windows/${TARGET_ARCHITECTURE}")
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/Windows/${TARGET_ARCHITECTURE}")
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/Windows/${TARGET_ARCHITECTURE}")
	
else()
	### Find cross-compilation configuration
	# Windows environment directories
	if(NOT "${CMAKE_HOST_WIN32}")
		if(NOT DEFINED WINDOWS_ENVIRONMENT_PATH OR NOT EXISTS "${WINDOWS_ENVIRONMENT_PATH}" OR NOT IS_DIRECTORY "${WINDOWS_ENVIRONMENT_PATH}")
			if(NOT EXISTS "/usr/${TARGET_ARCHITECTURE}-w64-mingw32" OR NOT IS_DIRECTORY "/usr/${TARGET_ARCHITECTURE}-w64-mingw32")
				set(RETURN_CODE 114)
				message(SEND_ERROR "No valid Environment path spcified, and default one can't be found (WINDOWS_ENVIRONMENT_PATH).")
			else()
				set(WINDOWS_ENVIRONMENT_PATH "/usr/${TARGET_ARCHITECTURE}-w64-mingw32")
			endif(NOT EXISTS "/usr/${TARGET_ARCHITECTURE}-w64-mingw32" OR NOT IS_DIRECTORY "/usr/${TARGET_ARCHITECTURE}-w64-mingw32")
		endif(NOT DEFINED WINDOWS_ENVIRONMENT_PATH OR NOT EXISTS "${WINDOWS_ENVIRONMENT_PATH}" OR NOT IS_DIRECTORY "${WINDOWS_ENVIRONMENT_PATH}")
		set(__tmp_windows_environment_path "${WINDOWS_ENVIRONMENT_PATH}")
		unset(WINDOWS_ENVIRONMENT_PATH CACHE)
		set(WINDOWS_ENVIRONMENT_PATH "${__tmp_windows_environment_path}" CACHE FILEPATH "Windows environment path for cross-compilation.")
		include_directories(SYSTEM
			"${WINDOWS_ENVIRONMENT_PATH}/usr/include"
			"${WINDOWS_ENVIRONMENT_PATH}/include"
		)
		link_directories(
			"${WINDOWS_ENVIRONMENT_PATH}/lib"
			"${WINDOWS_ENVIRONMENT_PATH}/usr/lib"
		)
	endif(NOT "${CMAKE_HOST_WIN32}")
	
	### Process configuration
	# Error in configuration, stop here
	if(NOT "${RETURN_CODE}" EQUAL "0")
		ReturnWithCode("Please review your configuration." ${RETURN_CODE})
	endif(NOT "${RETURN_CODE}" EQUAL "0")
	# Use config paths for C Compiler
	FindProgram(WINDOWS_C_COMPILER "${TARGET_ARCHITECTURE}-w64-mingw32-gcc${EXE_SUFFIX}" _FOUND "C Compiler")
	if(NOT _FOUND)
		unset(_FOUND CACHE)
		ReturnWithCode("C Compiler not found." 101)
	endif(NOT _FOUND)
	unset(_FOUND CACHE)
	get_filename_component(CROSS_TOOLS_PATH "${WINDOWS_C_COMPILER}" PATH)
	# Use config paths for CXX Compiler
	FindProgram(WINDOWS_CXX_COMPILER "${TARGET_ARCHITECTURE}-w64-mingw32-g++${EXE_SUFFIX}" _FOUND "CXX Compiler")
	if(NOT _FOUND)
		unset(_FOUND CACHE)
		ReturnWithCode("CXX Compiler not found." 101)
	endif(NOT _FOUND)
	unset(_FOUND CACHE)
	# Use config paths for linker
	FindProgram(WINDOWS_LINKER "${TARGET_ARCHITECTURE}-w64-mingw32-ld${EXE_SUFFIX}" _FOUND "Linker")
	if(NOT _FOUND)
		unset(_FOUND CACHE)
		find_program(WINDOWS_LINKER "ld" PATHS "${CROSS_TOOLS_PATH}" NO_DEFAULT_PATH)
		if("${WINDOWS_LINKER}" STREQUAL "WINDOWS_LINKER-NOTFOUND")
			unset(WINDOWS_LINKER CACHE)
			ReturnWithCode("Linker not found" 102)
		endif("${WINDOWS_LINKER}" STREQUAL "WINDOWS_LINKER-NOTFOUND")
		set(_tmp_windows_linker "${WINDOWS_LINKER}")
		unset(WINDOWS_LINKER CACHE)
		set(WINDOWS_LINKER "${_tmp_windows_linker}" CACHE INTERNAL "Linker")
		message(STATUS "Alternative Linker Found : ${WINDOWS_LINKER}")
	endif(NOT _FOUND)
	unset(_FOUND CACHE)
	# Use config paths for Archiver
	FindProgram(WINDOWS_AR "${TARGET_ARCHITECTURE}-w64-mingw32-ar${EXE_SUFFIX}" _FOUND "Archiver")
	if(NOT _FOUND)
		unset(_FOUND CACHE)
		find_program(WINDOWS_AR "ar" PATHS "${CROSS_TOOLS_PATH}" NO_DEFAULT_PATH)
		if("${WINDOWS_AR}" STREQUAL "WINDOWS_AR-NOTFOUND")
			unset(WINDOWS_AR CACHE)
			ReturnWithCode("Archiver not found" 103)
		endif("${WINDOWS_AR}" STREQUAL "WINDOWS_AR-NOTFOUND")
		set(_tmp_windows_ar "${WINDOWS_AR}")
		unset(WINDOWS_AR CACHE)
		set(WINDOWS_AR "${_tmp_windows_ar}" CACHE INTERNAL "Archiver")
		message(STATUS "Alternative Archiver Found : ${WINDOWS_AR}")
	endif(NOT _FOUND)
	unset(_FOUND CACHE)
	# Use config paths for Resource Compiler
	FindProgram(WINDOWS_RC_COMPILER "${TARGET_ARCHITECTURE}-w64-mingw32-rc${EXE_SUFFIX};${TARGET_ARCHITECTURE}-w64-mingw32-windres${EXE_SUFFIX}" _FOUND "Resource compiler")
	if(NOT _FOUND)
		unset(_FOUND CACHE)
		find_program(WINDOWS_RC_COMPILER NAMES "rc" "windres" PATHS "${CROSS_TOOLS_PATH}" NO_DEFAULT_PATH)
		if("${WINDOWS_RC_COMPILER}" STREQUAL "WINDOWS_RC_COMPILER-NOTFOUND")
			unset(WINDOWS_RC_COMPILER CACHE)
			ReturnWithCode("Resource Compiler not found." 105)
		endif("${WINDOWS_RC_COMPILER}" STREQUAL "WINDOWS_RC_COMPILER-NOTFOUND")
		set(_tmp_windows_rc_compiler "${WINDOWS_RC_COMPILER}")
		unset(WINDOWS_RC_COMPILER CACHE)
		set(WINDOWS_RC_COMPILER "${_tmp_windows_rc_compiler}")
		message(STATUS "Alternative Resource Compiler Found : ${WINDOWS_RC_COMPILER}")
	endif(NOT _FOUND)
	unset(_FOUND CACHE)
	
	### Set cmake internal variables
	# Utils
	set(CMAKE_C_COMPILER "${WINDOWS_C_COMPILER}")
	unset(WINDOWS_C_COMPILER CACHE)
	set(CMAKE_CXX_COMPILER "${WINDOWS_CXX_COMPILER}")
	unset(WINDOWS_CXX_COMPILER CACHE)
	set(CMAKE_C_LINK_EXECUTABLE "${WINDOWS_LINKER}")
	set(CMAKE_CXX_LINK_EXECUTABLE "${WINDOWS_LINKER}")
	unset(WINDOWS_LINKER CACHE)
	set(CMAKE_AR "${WINDOWS_AR}" CACHE FILEPATH "Path to windows Archiver")
	unset(WINDOWS_AR CACHE)
	set(CMAKE_RC_COMPILER "${WINDOWS_RC_COMPILER}")
	unset(WINDOWS_RC_COMPILER CACHE)
	# Force Compiler
	include( CMakeForceCompiler )
	CMAKE_FORCE_C_COMPILER("${CMAKE_C_COMPILER}" GNU)
	CMAKE_FORCE_CXX_COMPILER("${CMAKE_CXX_COMPILER}" GNU)
	# Flags
	set(CMAKE_CXX_FLAGS_DEBUG "${COMMON_C_FLAGS_DEBUG}" CACHE STRING "CXX Debug Flags")
	set(CMAKE_CXX_FLAGS_RELEASE "${COMMON_C_FLAGS_RELEASE}" CACHE STRING "CXX Release Flags")
	
	### Project Paths
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/${CMAKE_BUILD_TYPE}/Windows/${TARGET_ARCHITECTURE}")
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/${CMAKE_BUILD_TYPE}/Windows/${TARGET_ARCHITECTURE}")
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/${CMAKE_BUILD_TYPE}/Windows/${TARGET_ARCHITECTURE}")
endif("${CMAKE_GENERATOR}" MATCHES "Visual Studio*")

### Additional platform flag
remove_definitions(-DWIN32 -D_WIN32)
add_definitions(-DWIN32 -D_WIN32)