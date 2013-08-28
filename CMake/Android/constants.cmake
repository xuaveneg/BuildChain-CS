# Android Constants

# List of possible android architecture (see ${ANDROID_NDK}/docs/CPU-ARCH-ABIS.html)
set(ANDROID_ARCHITECTURE_LIST "armeabi;armeabi-v7a;x86;mips" CACHE INTERNAL "List of possible Android architectures for Mono")
# List of possible android versions (Those supported in Mono-Android)
set(ANDROID_API_VERSION_LIST "1.6;2.1;2.2;2.3;3.1;4.0;4.0.3;4.1;4.2;4.3" CACHE INTERNAL "List of possible Android api versions for Mono")

# Compiler Definitions (same definitions for C and CXX) (see Setup.mk in ndk toolchains)
# All architectures
set(ANDROID_C_DEFINITIONS "-DANDROID" CACHE INTERNAL "Additional Compiler Definitions for all configurations | all architectures")
set(ANDROID_C_DEFINITIONS_Release "" CACHE INTERNAL "Additional Compiler Definitions for Release | all architectures")
set(ANDROID_C_DEFINITIONS_Debug "-DDEBUG -D_DEBUG -DNDENUG" CACHE INTERNAL "Additional Compiler Defitions for Debug | all architectures")
# arm common
set(ANDROID_C_DEFINITIONS_arm "-D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__" CACHE INTERNAL "Additional Compiler Definitions for all configurations | armeabi & armeabi-v7a")
set(ANDROID_C_DEFINITIONS_arm_Release "" CACHE INTERNAL "Additional Compiler Definitions for Release | armeabi & armeabi-v7a")
set(ANDROID_C_DEFINITIONS_arm_Debug "" CACHE INTERNAL "Additional Compiler Definitions for Debug | armeabi & armeabi-v7a")
# armeabi
set(ANDROID_C_DEFINITIONS_armeabi "${ANDROID_C_DEFINITIONS_arm}" CACHE INTERNAL "Additional Compiler Definitions for all configurations | armeabi")
set(ANDROID_C_DEFINITIONS_armeabi_Release "${ANDROID_C_DEFINITIONS_arm_Release}" CACHE INTERNAL "Additional Compiler Definitions for Release | armeabi")
set(ANDROID_C_DEFINITIONS_armeabi_Debug "${ANDROID_C_DEFINITIONS_arm_Debug}" CACHE INTERNAL "Additional Compiler Definitions for Debug | armeabi")
# armeabi-v7a
set(ANDROID_C_DEFINITIONS_armeabi-v7a "${ANDROID_C_DEFINITIONS_arm}" CACHE INTERNAL "Additional Compiler Definitions for all configurations | armeabi-v7a")
set(ANDROID_C_DEFINITIONS_armeabi-v7a_Release "${ANDROID_C_DEFINITIONS_arm}" CACHE INTERNAL "Additional Compiler Definitions for Release | armeabi-v7a")
set(ANDROID_C_DEFINITIONS_armeabi-v7a_Debug "${ANDROID_C_DEFINITIONS_arm}" CACHE INTERNAL "Additional Compiler Definitions for Debug | armeabi-v7a")
# x86
set(ANDROID_C_DEFINITIONS_x86 "" CACHE INTERNAL "Additional Compiler Definitions for all configurations | x86")
set(ANDROID_C_DEFINITIONS_x86_Release "" CACHE INTERNAL "Additional Compiler Definitions for Release | x86")
set(ANDROID_C_DEFINITIONS_x86_Debug "" CACHE INTERNAL "Additional Compiler Definitions for Debug | x86")
# mips
set(ANDROID_C_DEFINITIONS_mips "" CACHE INTERNAL "Additional Compiler Definitions for all configuration | mips")
set(ANDROID_C_DEFINITIONS_mips_Release "" CACHE INTERNAL "Additional Compiler Definitions for Release | mips")
set(ANDROID_C_DEFINITIONS_mips_Debug "" CACHE INTERNAL "Additional Compiler Definitions for Debug | mips")

# Compiler Flags (same flags for C and CXX) (see Setup.mk in ndk toolchains)
# All architectures
set(ANDROID_C_FLAGS "" CACHE INTERNAL "Android C Flags for all configurations | all architectures")
set(ANDROID_C_FLAGS_Release "" CACHE INTERNAL "Android C Flags for Release | all architectures")
set(ANDROID_C_FLAGS_Debug "" CACHE INTERNAL "Android C Flags for Debug | all architectures")
# arm common
set(ANDROID_C_FLAGS_arm "-fpic -ffunction-sections -funwind-tables -fstack-protector -no-canonical-prefixes" CACHE INTERNAL "Android C Flags for all configurations | armeabi & armeabi-v7a")
set(ANDROID_C_FLAGS_arm_Release "-mthumb -fomit-frame-pointer -fno-strict-aliasing" CACHE INTERNAL "Android C Flags for Release | armeabi & armeabi-v7a")
set(ANDROID_C_FLAGS_arm_Debug "-fno-omit-frame-pointer -fno-strict-aliasing -funswitch-loops -finline-limit=300" CACHE INTERNAL "Android C Flags for Debug | armeabi & armeabi-v7a")
# armeabi
set(ANDROID_C_FLAGS_armeabi "${ANDROID_C_FLAGS_arm} -march=armv5te -mtune=xscale -msoft-float" CACHE INTERNAL "Android C Flags for all configurations | armeabi")
set(ANDROID_C_FLAGS_armeabi_Release "${ANDROID_C_FLAGS_arm_Release}" CACHE INTERNAL "Android C Flags for Release | armeabi")
set(ANDROID_C_FLAGS_armeabi_Debug "${ANDROID_C_FLAGS_arm_Debug}" CACHE INTERNAL "Android C Flags for Debug | armeabi")
# armeabi-v7a
set(ANDROID_C_FLAGS_armeabi-v7a "${ANDROID_C_FLAGS_arm} -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16" CACHE INTERNAL "Android C Flags for all configurations | armeabi-v7a")
set(ANDROID_C_FLAGS_armeabi-v7a_Release "${ANDROID_C_FLAGS_arm_Release}" CACHE INTERNAL "Android C Flags for Release | armeabi-v7a")
set(ANDROID_C_FLAGS_armeabi-v7a_Debug "${ANDROID_C_FLAGS_arm_Debug}" CACHE INTERNAL "Android C Flags for Debug | armeabi-v7a")
# x86
set(ANDROID_C_FLAGS_x86 "-ffunction-sections -funwind-tables -no-canonical-prefixes -fstack-protector" CACHE INTERNAL "Android C Flags for all configurations | x86")
set(ANDROID_C_FLAGS_x86_Release "-fomit-frame-pointer -fstrict-aliasing -funswitch-loops" CACHE INTERNAL "Android C Flags for Release | x86")
set(ANDROID_C_FLAGS_x86_Debug "-fno-omit-frame-pointer -fno-strict-aliasing -funswitch-loops -finline-limit=300" CACHE INTERNAL "Android C Flags for Debug | x86")
# mips
set(ANDROID_C_FLAGS_mips "-fpic -fno-strict-aliasing -finline-functions -ffunction-sections -funwind-tables -fmessage-length=0 -fno-inline-functions-called-once -fgcse-after-reload -frerun-cse-after-loop -frename-registers -no-canonical-prefixes" CACHE INTERNAL "Android C Flags for all configurations | mips")
set(ANDROID_C_FLAGS_mips_Release "-fomit-frame-pointer -funswitch-loops" CACHE INTERNAL "Android C Flags for Release | mips")
set(ANDROID_C_FLAGS_mips_Debug "-fno-omit-frame-pointer -funswitch-loops -finline-limit=300" CACHE INTERNAL "Android C Flags for Debug | mips")

# Linker flags
# All architectures
set(ANDROID_LINKER_FLAGS "" CACHE INTERNAL "Android Linker Flags for all architectures")
# arm common
set(ANDROID_LINKER_FLAGS_arm "-no-canonical-prefixes" CACHE INTERNAL "Android Linker Flags for armeabi & armabi-v7a")
# armeabi
set(ANDROID_LINKER_FLAGS_armeabi "${ANDROID_LINKER_FLAGS_arm}" CACHE INTERNAL "Android Linker Flags for armeabi")
# armeabi-v7a
set(ANDROID_LINKER_FLAGS_armeabi-v7a "${ANDROID_LINKER_FLAGS_arm} -march=armv7-a -Wl,--fix-cortex-a8" CACHE INTERNAL "Android Linker Flags for armeabi-v7a")
# x86
set(ANDROID_LINKER_FLAGS_x86 "-no-canonical-prefixes" CACHE INTERNAL "Android Linker Flags for x86")
# mips
set(ANDROID_LINKER_FLAGS_mips "-no-canonical-prefixes" CACHE INTERNAL "Android Linker Flags for mips")

# Android Map api level -> minimum version (http://developer.android.com/guide/topics/manifest/uses-sdk-element.html#ApiLevels)
set(ANDROID_API_LEVEL_TO_VERSION_1  1.0   CACHE INTERNAL "api_level=1  -> Version=1.0")
set(ANDROID_API_LEVEL_TO_VERSION_2  1.1   CACHE INTERNAL "api_level=2  -> Version=1.1")
set(ANDROID_API_LEVEL_TO_VERSION_3  1.5   CACHE INTERNAL "api_level=3  -> Version=1.5")
set(ANDROID_API_LEVEL_TO_VERSION_4  1.6   CACHE INTERNAL "api_level=4  -> Version=1.6")
set(ANDROID_API_LEVEL_TO_VERSION_5  2.0   CACHE INTERNAL "api_level=5  -> Version=2.0")
set(ANDROID_API_LEVEL_TO_VERSION_6  2.0.1 CACHE INTERNAL "api_level=6  -> Version=2.0.1")
set(ANDROID_API_LEVEL_TO_VERSION_7  2.1   CACHE INTERNAL "api_level=7  -> Version=2.1.x")
set(ANDROID_API_LEVEL_TO_VERSION_8  2.2   CACHE INTERNAL "api_level=8  -> Version=2.2.x")
set(ANDROID_API_LEVEL_TO_VERSION_9  2.3   CACHE INTERNAL "api_level=9  -> Version=2.3|2.3.1|2.3.2")
set(ANDROID_API_LEVEL_TO_VERSION_10 2.3.3 CACHE INTERNAL "api_level=10 -> Version=2.3.3|2.3.4")
set(ANDROID_API_LEVEL_TO_VERSION_11 3.0   CACHE INTERNAL "api_level=11 -> Version=3.0.x")
set(ANDROID_API_LEVEL_TO_VERSION_12 3.1   CACHE INTERNAL "api_level=12 -> Version=3.1.x")
set(ANDROID_API_LEVEL_TO_VERSION_13 3.2   CACHE INTERNAL "api_level=13 -> Version=3.2")
set(ANDROID_API_LEVEL_TO_VERSION_14 4.0   CACHE INTERNAL "api_level=14 -> Version=4.0|4.0.1|4.0.2")
set(ANDROID_API_LEVEL_TO_VERSION_15 4.0.3 CACHE INTERNAL "api_level=15 -> Version=4.0.3|4.0.4")
set(ANDROID_API_LEVEL_TO_VERSION_16 4.1   CACHE INTERNAL "api_level=16 -> Version=4.1|4.1.1")
set(ANDROID_API_LEVEL_TO_VERSION_17 4.2   CACHE INTERNAL "api_level=17 -> Version=4.2|4.2.2")
set(ANDROID_API_LEVEL_TO_VERSION_18 4.3	  CACHE INTERNAL "api_level=18 -> Version=4.3")
# Android Map version -> minimum api level (http://developer.android.com/guide/topics/manifest/uses-sdk-element.html#ApiLevels)
set(ANDROID_VERSION_TO_API_LEVEL_1.0   1  CACHE INTERNAL "api_level=1  <- Version=1.0")
set(ANDROID_VERSION_TO_API_LEVEL_1.1   2  CACHE INTERNAL "api_level=2  <- Version=1.1")
set(ANDROID_VERSION_TO_API_LEVEL_1.5   3  CACHE INTERNAL "api_level=3  <- Version=1.5")
set(ANDROID_VERSION_TO_API_LEVEL_1.6   4  CACHE INTERNAL "api_level=4  <- Version=1.6")
set(ANDROID_VERSION_TO_API_LEVEL_2.0   5  CACHE INTERNAL "api_level=5  <- Version=2.0")
set(ANDROID_VERSION_TO_API_LEVEL_2.0.1 6  CACHE INTERNAL "api_level=6  <- Version=2.0.1")
set(ANDROID_VERSION_TO_API_LEVEL_2.1   7  CACHE INTERNAL "api_level=7  <- Version=2.1.x")
set(ANDROID_VERSION_TO_API_LEVEL_2.2   8  CACHE INTERNAL "api_level=8  <- Version=2.2.x")
set(ANDROID_VERSION_TO_API_LEVEL_2.3   9  CACHE INTERNAL "api_level=9  <- Version=2.3")
set(ANDROID_VERSION_TO_API_LEVEL_2.3.1 9  CACHE INTERNAL "api_level=9  <- Version=2.3.1")
set(ANDROID_VERSION_TO_API_LEVEL_2.3.2 9  CACHE INTERNAL "api_level=9  <- Version=2.3.2")
set(ANDROID_VERSION_TO_API_LEVEL_2.3.3 10 CACHE INTERNAL "api_level=10 <- Version=2.3.3")
set(ANDROID_VERSION_TO_API_LEVEL_2.3.4 10 CACHE INTERNAL "api_level=10 <- Version=2.3.4")
set(ANDROID_VERSION_TO_API_LEVEL_3.0   11 CACHE INTERNAL "api_level=11 <- Version=3.0.x")
set(ANDROID_VERSION_TO_API_LEVEL_3.1   12 CACHE INTERNAL "api_level=12 <- Version=3.1.x")
set(ANDROID_VERSION_TO_API_LEVEL_3.2   13 CACHE INTERNAL "api_level=13 <- Version=3.2")
set(ANDROID_VERSION_TO_API_LEVEL_4.0   14 CACHE INTERNAL "api_level=14 <- Version=4.0")
set(ANDROID_VERSION_TO_API_LEVEL_4.0.1 14 CACHE INTERNAL "api_level=14 <- Version=4.0.1")
set(ANDROID_VERSION_TO_API_LEVEL_4.0.2 14 CACHE INTERNAL "api_level=14 <- Version=4.0.2")
set(ANDROID_VERSION_TO_API_LEVEL_4.0.3 15 CACHE INTERNAL "api_level=15 <- Version=4.0.3")
set(ANDROID_VERSION_TO_API_LEVEL_4.0.4 15 CACHE INTERNAL "api_level=15 <- Version=4.0.4")
set(ANDROID_VERSION_TO_API_LEVEL_4.1   16 CACHE INTERNAL "api_level=16 <- Version=4.1")
set(ANDROID_VERSION_TO_API_LEVEL_4.1.1 16 CACHE INTERNAL "api_level=16 <- Version=4.1.1")
set(ANDROID_VERSION_TO_API_LEVEL_4.2   17 CACHE INTERNAL "api_level=17 <- Version=4.2")
set(ANDROID_VERSION_TO_API_LEVEL_4.2.2 17 CACHE INTERNAL "api_level=17 <- Version=4.2.2")
set(ANDROID_VERSION_TO_API_LEVEL_4.3   18 CACHE INTERNAL "api_level=18 <- Version=4.3")
# Android Map architecture (in config) -> architecture (in path)
set(ANDROID_ARCHITECTURE_INPATH_armeabi     "arm"    CACHE INTERNAL "armeabi     -> arm")
set(ANDROID_ARCHITECTURE_INPATH_armeabi-v7a "arm"    CACHE INTERNAL "armeabi-v7a -> arm")
set(ANDROID_ARCHITECTURE_INPATH_x86         "x86"    CACHE INTERNAL "x86         -> x86")
set(ANDROID_ARCHITECTURE_INPATH_mips        "mipsel" CACHE INTERNAL "mips        -> mipsel")