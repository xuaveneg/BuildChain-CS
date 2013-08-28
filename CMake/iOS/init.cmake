# iOS Main File
cmake_minimum_required(VERSION 2.8.5)

### Target Platorm Informations
set(CMAKE_SYSTEM_NAME "Darwin")
set(CMAKE_SYSTEM_VERSION 1)

### Check if we're the builder is Xcode on Apple
if(NOT CMAKE_HOST_APPLE)
	ReturnWithCode("Cannot build for iOS under a non-Apple platform." 3)
endif(NOT CMAKE_HOST_APPLE)
if(NOT "${CMAKE_GENERATOR}" STREQUAL "Xcode")
	ReturnWithCode("Please use Xcode to build for iOS." 4)
endif(NOT "${CMAKE_GENERATOR}" STREQUAL "Xcode")

### Find user configuration
set(RETURN_CODE 0)
FindValidParameter(TARGET_ARCHITECTURE "${IOS_ARCHITECTURE_LIST}" _FOUND "iOS Architecture")
if(NOT _FOUND)
	set(RETURN_CODE 113)
	message(SEND_ERROR
		"Please set a valid architecture for iOS (TARGET_ARCHITECTURE).\nValids Architectures are ${IOS_ARCHITECTURE_LIST}.")
else()
	message(STATUS "Targeting Architecture ${TARGET_ARCHITECTURE}")
endif(NOT _FOUND)
# Error in configuration : Stop Processing
if(NOT "${RETURN_CODE}" EQUAL "0")
	ReturnWithCode("Please review your configuration." ${RETURN_CODE})
endif(NOT "${RETURN_CODE}" EQUAL "0")

### Processing
# We don't want any shared libraries.
unset(SHARED CACHE)
set(SHARED "" CACHE INTERNAL "Argument to add to add_library for Shared (dynamic) libraries.")
# Print Build Command
message(STATUS "To build, please run the following command :\n${IOS_BUILD_COMMAND_${TARGET_ARCHITECTURE}}")

### Flags
remove_definitions(${IOS_C_DEFINITIONS})
add_definitions(${IOS_C_DEFINITIONS})

### Force Clang Compiler, as recommended by Apple
include(CMakeForceCompiler)
CMAKE_FORCE_C_COMPILER(clang CLang)
CMAKE_FORCE_CXX_COMPILER(clang++ CLang)

### Project Paths
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/${CMAKE_BUILD_TYPE}/iOS/${TARGET_ARCHITECTURE}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${OUTPUT_ROOT_DIRECTORY}/Debug/iOS/${TARGET_ARCHITECTURE}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${OUTPUT_ROOT_DIRECTORY}/Debug/iOS/${TARGET_ARCHITECTURE}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${OUTPUT_ROOT_DIRECTORY}/Debug/iOS/${TARGET_ARCHITECTURE}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${OUTPUT_ROOT_DIRECTORY}/Release/iOS/${TARGET_ARCHITECTURE}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${OUTPUT_ROOT_DIRECTORY}/Release/iOS/${TARGET_ARCHITECTURE}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OUTPUT_ROOT_DIRECTORY}/Release/iOS/${TARGET_ARCHITECTURE}")