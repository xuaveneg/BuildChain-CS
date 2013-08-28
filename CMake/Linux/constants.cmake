# Linux Constants

# List of possible linux architecture
set(LINUX_ARCHITECTURE_LIST "i386;i686;x86_64" CACHE INTERNAL "List of possible Linux architectures")

# List of compilers to search, ordered by preference
set(LINUX_C_COMPILER_LIST "clang;gcc" CACHE INTERNAL "List of C Compiler for Linux")
set(LINUX_C_COMPILER_ID_LIST "Clang;GNU" CACHE INTERNAL "List of C Compiler Id for Linux")
set(LINUX_CXX_COMPILER_LIST "clang++;g++" CACHE INTERNAL "List of CXX Compiler for Linux")
set(LINUX_CXX_COMPILER_ID_LIST "Clang;GNU" CACHE INTERNAL "List of CXX Compiler Id for Linux")