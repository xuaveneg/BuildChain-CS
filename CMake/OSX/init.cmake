# OSX Main File
cmake_minimum_required(VERSION 2.8.5)

### Target Platorm Informations
set(CMAKE_SYSTEM_NAME "Darwin")
set(CMAKE_SYSTEM_VERSION 1)

### Check if we're the builder is Xcode on Apple
if(NOT CMAKE_HOST_APPLE)
	ReturnWithCode("Cannot build for OSX under a non-Apple platform." 3)
endif(NOT CMAKE_HOST_APPLE)
if(NOT "${CMAKE_GENERATOR}" STREQUAL "Xcode")
	ReturnWithCode("Please use Xcode to build for OSX." 4)
endif(NOT "${CMAKE_GENERATOR}" STREQUAL "Xcode")

### Find user configuration
set(RETURN_CODE 0)
FindValidParameter(TARGET_ARCHITECTURE "${OSX_ARCHITECTURE_LIST}" _FOUND "OSX Architecture")
if(NOT _FOUND)
	set(RETURN_CODE 113)
	message(SEND_ERROR
		"Please set a valid architecture for OSX (OSX_ARCHITECTURE).\nValids Architectures are ${OSX_ARCHITECTURE_LIST}.")
else()
	message(STATUS "Targeting Architecture ${TARGET_ARCHITECTURE}")
endif(NOT _FOUND)
# Error in configuration : Stop Processing
if(NOT "${RETURN_CODE}" EQUAL "0")
	ReturnWithCode("Please review your configuration." ${RETURN_CODE})
endif(NOT "${RETURN_CODE}" EQUAL "0")

### Processing
# Print Build Command
message(STATUS "To build, please run the following command :\nxcodebuild -arch ${TARGET_ARCHITECTURE} -configuration ${CMAKE_BUILD_TYPE} clean build")

### Flags
remove_definitions(${OSX_C_DEFINITIONS})
add_definitions(${OSX_C_DEFINITIONS})

### Force Clang Compiler, as recommended by Apple
include(CMakeForceCompiler)
CMAKE_FORCE_C_COMPILER(clang CLang)
CMAKE_FORCE_CXX_COMPILER(clang++ CLang)

### Project Paths
# Build Type automatically added with xcode
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/${CMAKE_BUILD_TYPE}/OSX/${TARGET_ARCHITECTURE}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${OUTPUT_ROOT_DIRECTORY}/Debug/OSX/${TARGET_ARCHITECTURE}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${OUTPUT_ROOT_DIRECTORY}/Debug/OSX/${TARGET_ARCHITECTURE}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${OUTPUT_ROOT_DIRECTORY}/Debug/OSX/${TARGET_ARCHITECTURE}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${OUTPUT_ROOT_DIRECTORY}/Release/OSX/${TARGET_ARCHITECTURE}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${OUTPUT_ROOT_DIRECTORY}/Release/OSX/${TARGET_ARCHITECTURE}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${OUTPUT_ROOT_DIRECTORY}/Release/OSX/${TARGET_ARCHITECTURE}")
