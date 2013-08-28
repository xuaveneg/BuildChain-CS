# Common Constants

# Unset old internal variables
unset(CMAKE_RUNTIME_OUTPUT_DIRECTORY CACHE)
unset(CMAKE_LIBRARY_OUTPUT_DIRECTORY CACHE)
unset(CMAKE_ARCHIVE_OUTPUT_DIRECTORY CACHE)

# List of possible targets
set(TARGET_PLATFORM_LIST "Android;Windows;Linux;iOS;OSX" CACHE INTERNAL "List of possible targets")
# List of possible configs
set(BUILD_TYPE_LIST "Debug;Release" CACHE INTERNAL "List of possible build types")
# Standard common flags for used compilers (clang - gcc)
set(COMMON_C_FLAGS_DEBUG "-ggdb -O0" CACHE INTERNAL "Common Compiler Flags For Debug")
set(COMMON_C_FLAGS_RELEASE "-O3" CACHE INTERNAL "Common Compiler Flags For Release")