# Linux Main File
cmake_minimum_required(VERSION 2.8.5)

### Platform Name
set(CMAKE_SYSTEM_NAME "Linux")
set(CMAKE_SYSTEM_VERSION 1)
message(STATUS "Host architecture : ${CMAKE_HOST_SYSTEM_PROCESSOR}")

### Find user configuration
set(RETURN_CODE 0)
# Linux Architecture
FindValidParameter(TARGET_ARCHITECTURE "${LINUX_ARCHITECTURE_LIST}" _FOUND "Linux Architecture")
if(NOT _FOUND)
	set(RETURN_CODE 113)
	message(SEND_ERROR
		"Please set a valid Architecture for Linux.\nValids Architectures are ${LINUX_ARCHITECTURE_LIST}.")
else()
	set(CMAKE_SYSTEM_PROCESSOR "${TARGET_ARCHITECTURE}")
endif(NOT _FOUND)
# Error in configuration : Stop Processing
if(NOT "${RETURN_CODE}" EQUAL "0")
	ReturnWithCode("Please review your configuration." ${RETURN_CODE})
endif(NOT "${RETURN_CODE}" EQUAL "0")

### Processing
set(LINUX_C_COMPILER "LINUX_C_COMPILER-NOTFOUND")
if("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "${TARGET_ARCHITECTURE}")
	foreach(_compiler ${LINUX_C_COMPILER_LIST})
		unset(LINUX_C_COMPILER CACHE)
		find_program(LINUX_C_COMPILER "${_compiler}")
		if(NOT "${LINUX_C_COMPILER}" STREQUAL "LINUX_C_COMPILER-NOTFOUND")
			break()
		endif(NOT "${LINUX_C_COMPILER}" STREQUAL "LINUX_C_COMPILER-NOTFOUND")
		message(STATUS "${_compiler} not found.")
	endforeach(_compiler ${LINUX_C_COMPILER_LIST})
endif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "${TARGET_ARCHITECTURE}")
if("${LINUX_C_COMPILER}" STREQUAL "LINUX_C_COMPILER-NOTFOUND")
	foreach(_compiler ${LINUX_C_COMPILER_LIST})
		unset(LINUX_C_COMPILER CACHE)
		find_program(LINUX_C_COMPILER "${TARGET_ARCHITECTURE}-linux-gnu-${_compiler}")
		if(NOT "${LINUX_C_COMPILER}" STREQUAL "LINUX_C_COMPILER-NOTFOUND")
			break()
		endif(NOT "${LINUX_C_COMPILER}" STREQUAL "LINUX_C_COMPILER-NOTFOUND")
		message(STATUS "${TARGET_ARCHITECTURE}-linux-gnu-${_compiler} not found.")
	endforeach(_compiler ${LINUX_C_COMPILER_LIST})
endif("${LINUX_C_COMPILER}" STREQUAL "LINUX_C_COMPILER-NOTFOUND")
set(_tmp_linux_c_compiler "${LINUX_C_COMPILER}")
unset(LINUX_C_COMPILER CACHE)
set(LINUX_C_COMPILER "${_tmp_linux_c_compiler}")
set(LINUX_CXX_COMPILER "LINUX_CXX_COMPILER-NOTFOUND")
if("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "${TARGET_ARCHITECTURE}")
	foreach(_compiler ${LINUX_CXX_COMPILER_LIST})
		unset(LINUX_CXX_COMPILER CACHE)
		find_program(LINUX_CXX_COMPILER "${_compiler}")
		if(NOT "${LINUX_CXX_COMPILER}" STREQUAL "LINUX_CXX_COMPILER-NOTFOUND")
			break()
		endif(NOT "${LINUX_CXX_COMPILER}" STREQUAL "LINUX_CXX_COMPILER-NOTFOUND")
		message(STATUS "${_compiler} not found.")
	endforeach(_compiler ${LINUX_C_COMPILER_LIST})
endif("${CMAKE_HOST_SYSTEM_PROCESSOR}" STREQUAL "${TARGET_ARCHITECTURE}")
if("${LINUX_CXX_COMPILER}" STREQUAL "LINUX_CXX_COMPILER-NOTFOUND")
	foreach(_compiler ${LINUX_CXX_COMPILER_LIST})
		unset(LINUX_CXX_COMPILER CACHE)
		find_program(LINUX_CXX_COMPILER "${TARGET_ARCHITECTURE}-linux-gnu-${_compiler}")
		if(NOT "${LINUX_CXX_COMPILER}" STREQUAL "LINUX_CXX_COMPILER-NOTFOUND")
			break()
		endif(NOT "${LINUX_CXX_COMPILER}" STREQUAL "LINUX_CXX_COMPILER-NOTFOUND")
		message(STATUS "${TARGET_ARCHITECTURE}-linux-gnu-${_compiler} not found.")
	endforeach(_compiler ${LINUX_CXX_COMPILER_LIST})
endif("${LINUX_CXX_COMPILER}" STREQUAL "LINUX_CXX_COMPILER-NOTFOUND")
set(_tmp_linux_cxx_compiler "${LINUX_CXX_COMPILER}")
unset(LINUX_CXX_COMPILER CACHE)
set(LINUX_CXX_COMPILER "${_tmp_linux_cxx_compiler}")
if((NOT "${LINUX_C_COMPILER}" STREQUAL "LINUX_C_COMPILER-NOTFOUND") AND (NOT "${LINUX_CXX_COMPILER}" STREQUAL "LINUX_CXX_COMPILER-NOTFOUND"))
	list(FIND "${LINUX_C_COMPILER_LIST}" "${LINUX_C_COMPILER}" _INDEX)
	list(GET "${LINUX_C_COMPILER_ID_LIST}" "${_INDEX}" LINUX_C_COMPILER_ID)
	list(FIND "${LINUX_CXX_COMPILER_LIST}" "${LINUX_CXX_COMPILER}" _INDEX)
	list(GET "${LINUX_CXX_COMPILER_ID_LIST}" "${_INDEX}" LINUX_CXX_COMPILER_ID)
else()
	ReturnWithCode("No Compiler Found." 101)
endif((NOT "${LINUX_C_COMPILER}" STREQUAL "LINUX_C_COMPILER-NOTFOUND") AND (NOT "${LINUX_CXX_COMPILER}" STREQUAL "LINUX_CXX_COMPILER-NOTFOUND"))

### Flags
set(CMAKE_C_FLAGS "-march=${TARGET_ARCHITECTURE}" CACHE STRING "C Flags")
set(CMAKE_C_FLAGS_DEBUG "${COMMON_C_FLAGS_DEBUG}" CACHE STRING "C Flags Debug")
set(CMAKE_C_FLAGS_RELEASE "${COMMON_C_FLAGS_RELEASE}" CACHE STRING "C Flags Release")
set(CMAKE_CXX_FLAGS "-march=${TARGET_ARCHITECTURE}" CACHE STRING "CXX Flags")
set(CMAKE_CXX_FLAGS_DEBUG "${COMMON_C_FLAGS_DEBUG}" CACHE STRING "CXX Flags Debug")
set(CMAKE_CXX_FLAGS_RELEASE "${COMMON_C_FLAGS_RELEASE}" CACHE STRING "CXX Flags Release")
remove_definitions(-DLINUX)
add_definitions(-DLINUX)

### Force First Found Compiler
include(CMakeForceCompiler)
CMAKE_FORCE_C_COMPILER("${LINUX_C_COMPILER}" "${LINUX_C_COMPILER_ID}")
CMAKE_FORCE_CXX_COMPILER("${LINUX_CXX_COMPILER}" "${LINUX_CXX_COMPILER_ID}")

### Project Paths
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/${CMAKE_BUILD_TYPE}/Linux/${TARGET_ARCHITECTURE}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/${CMAKE_BUILD_TYPE}/Linux/${TARGET_ARCHITECTURE}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${OUTPUT_ROOT_DIRECTORY}/${CMAKE_BUILD_TYPE}/Linux/${TARGET_ARCHITECTURE}")