# Main File
cmake_minimum_required(VERSION 2.8.5)

### Includes
include("${CMAKE_CURRENT_LIST_DIR}/config.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/constants.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/utils.cmake")

### Common variables to set
# Target Platform
# Check if a valid Target Platform was given
FindValidParameter(TARGET_PLATFORM "${TARGET_PLATFORM_LIST}" _FOUND "Targeted Platform")
if(NOT _FOUND)
	ReturnWithCode("Please set a valid platform (TARGET_PLATFORM).\nValids Platforms are ${TARGET_PLATFORM_LIST}." 2)
endif(NOT _FOUND)
# Check for a valid Build Type
FindValidParameter(CMAKE_BUILD_TYPE "${BUILD_TYPE_LIST}" _FOUND "Build Type")
if(NOT _FOUND)
	ReturnWithCode("Please set a valid build type (CMAKE_BUILD_TYPE).\nValids Build Types are ${BUILD_TYPE_LIST}." 111)
endif(NOT _FOUND)
# A variable used to know if libraries are static are dynamic (shared)
set(SHARED "SHARED" CACHE INTERNAL "Argument to add to add_library for Shared (dynamic) libraries.")
# (Optional) Output root directory
if("${OUTPUT_ROOT_DIRECTORY}" STREQUAL "")
	set(OUTPUT_ROOT_DIRECTORY "${PROJECT_SOURCE_DIR}/lib" CACHE PATH "Path to the root output directory")
else()
	set(_tmp_output_root_directory "${OUTPUT_ROOT_DIRECTORY}")
	unset(OUTPUT_ROOT_DIRECTORY CACHE)
	set(OUTPUT_ROOT_DIRECTORY "${_tmp_output_root_directory}" CACHE PATH "Path to the root output directory")
endif("${OUTPUT_ROOT_DIRECTORY}" STREQUAL "")

### Common additional Processing
# Find executable extension for the building platform (may be used sometimes)
set(EXE_SUFFIX "")
if(CMAKE_HOST_WIN32)
	set(EXE_SUFFIX ".exe")
endif(CMAKE_HOST_WIN32)
# Check generator : Visual Studio can only build for windows
if(CMAKE_GENERATOR MATCHES "Visual Studio*" AND NOT "${TARGET_PLATFORM}" STREQUAL "Windows")
	ReturnWithCode("Can't build for the target ${TARGET_PLATFORM} with ${CMAKE_GENERATOR}" 5)
endif(CMAKE_GENERATOR MATCHES "Visual Studio*" AND NOT "${TARGET_PLATFORM}" STREQUAL "Windows")
# Choose the right file depending on the specified target
message(STATUS "Generating build for ${TARGET_PLATFORM}")
include("${CMAKE_CURRENT_LIST_DIR}/${TARGET_PLATFORM}/constants.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/${TARGET_PLATFORM}/init.cmake")
# Infos
message(STATUS "C Compiler : ${CMAKE_C_COMPILER}")
message(STATUS "CXX Compiler : ${CMAKE_CXX_COMPILER}")

# Check for install_name_tool on Apple, in the same directory as the C compiler
if(CMAKE_HOST_APPLE)
	find_program(APPLE_INSTALL_NAME_TOOL install_name_tool)
	set(CMAKE_INSTALL_NAME_TOOL "${APPLE_INSTALL_NAME_TOOL}" CACHE INTERNAL "Apple's util install_name_tool")
	unset(APPLE_INSTALL_NAME_TOOL CACHE)
	if("${CMAKE_INSTALL_NAME_TOOL}" STREQUAL "APPLE_INSTALL_NAME_TOOL-NOTFOUND")
		ReturnWithCode("Cannot find install_name_tool.\nYou may have to add Xcode's binaries  path (should look like /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin) to your path." 104)
	endif("${CMAKE_INSTALL_NAME_TOOL}" STREQUAL "APPLE_INSTALL_NAME_TOOL-NOTFOUND")
endif(CMAKE_HOST_APPLE)

include("${CMAKE_CURRENT_LIST_DIR}/postUtils.cmake")