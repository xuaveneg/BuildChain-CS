# iOS Constants

# List of possible architectures
set(IOS_ARCHITECTURE_LIST "armv6;armv7;i386" CACHE INTERNAL "List of possible iOS architectures")

# Compiler Definitions
set(IOS_C_DEFINITIONS "-DIOS" CACHE INTERNAL "Additional Compiler Definitions for all configurations | all architecture")

# Command Build depending on the architecture
set(IOS_BUILD_COMMAND_armv6 "xcodebuild VALID_ARCHS=${IOS_ARCHITECTURE_LIST} -sdk iphoneos -arch armv6 -configuration ${CMAKE_BUILD_TYPE} clean build" CACHE INTERNAL "Build Command for armv6 Architecture")
set(IOS_BUILD_COMMAND_armv7 "xcodebuild VALID_ARCHS=${IOS_ARCHITECTURE_LIST} -sdk iphoneos -arch armv7 -configuration ${CMAKE_BUILD_TYPE} clean build" CACHE INTERNAL "Build Command for armv7 Architecture")
set(IOS_BUILD_COMMAND_i386 "xcodebuild VALID_ARCHS=${IOS_ARCHITECTURE_LIST} -sdk iphonesimulator -arch i386 -configuration ${CMAKE_BUILD_TYPE} clean build" CACHE INTERNAL "Build Command for i386 Architecture")