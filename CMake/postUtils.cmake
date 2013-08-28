macro(native_library TARGET)
	# Language : c++
	enable_language(CXX)
	# Create library project
	add_library(${TARGET} ${SHARED} ${ARGN})
	if("${TARGET_PLATFORM}" STREQUAL "Windows")
		set_target_properties(${TARGET} PROPERTIES PREFIX "")
	endif("${TARGET_PLATFORM}" STREQUAL "Windows")
	# Store the current project name
	set(CURRENT_TARGET_NAME ${TARGET})
endmacro(native_library)

macro(link_native_library PATH)
	# Search library name from CMakeLists file
	# TODO : Improve Regex
	file(GLOB CMAKE_FILE "${PATH}/*.cmake")
	list(GET CMAKE_FILE 0 CMAKE_FILE)
	message(STATUS "${CMAKE_FILE}")
	file(STRINGS "${CMAKE_FILE}" __Content REGEX "^native_library\\(")
	string(REPLACE "native_library\(" "" __Content "${__Content}")
	list(GET __Content 0 LINK_TARGET_NAME)
	if(("${LINK_TARGET_NAME}" STREQUAL "") OR ("${LINK_TARGET_NAME}" STREQUAL "NOTFOUND"))
		message(WARNING "${PATH}/CMakeLists.txt does not contains a valid native library definition.")
	else()
		# Include CMakeLists file
		add_subdirectory("${PATH}" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
		# Link Libraries
		target_link_libraries("${CURRENT_TARGET_NAME}"
			"${LINK_TARGET_NAME}"
		)
	endif(("${LINK_TARGET_NAME}" STREQUAL "") OR ("${LINK_TARGET_NAME}" STREQUAL "NOTFOUND"))
endmacro(link_native_library)