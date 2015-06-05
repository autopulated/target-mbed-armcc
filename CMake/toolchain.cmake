# Copyright (C) 2014-2015 ARM Limited. All rights reserved. 

if(TARGET_MBED_ARMCC_TOOLCHAIN_INCLUDED)
    return()
endif()
set(TARGET_MBED_ARMCC_TOOLCHAIN_INCLUDED 1)

# search path for included .cmake files (set this as early as possible, so that
# indirect includes still use it)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")

include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME mbedOS)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR "armv7-m")

# post-process elf files into .bin files:
find_program(ARMCC_FROMELF fromelf)
set(YOTTA_POSTPROCESS_COMMAND "${ARMCC_FROMELF} --bin YOTTA_CURRENT_EXE_NAME --output YOTTA_CURRENT_EXE_NAME.bin")

# set default compilation flags
set(_C_FAMILY_FLAGS_INIT "--split_sections --apcs=interwork --restrict --no_rtti --multibyte-chars")
set(CMAKE_C_FLAGS_INIT   "--c99 ${_C_FAMILY_FLAGS_INIT}")
set(CMAKE_ASM_FLAGS_INIT "--gnu --split_sections --apcs=interwork --restrict --no_rtti")
set(CMAKE_CXX_FLAGS_INIT "${_C_FAMILY_FLAGS_INIT} --no_exceptions")
set(CMAKE_MODULE_LINKER_FLAGS_INIT "")
set(CMAKE_EXE_LINKER_FLAGS_INIT "${CMAKE_MODULE_LINKER_FLAGS_INIT}") 

# Set the compiler to ARMCC
include(CMakeForceCompiler)

cmake_force_c_compiler(armcc ARMCC)
cmake_force_cxx_compiler(armcc ARMCC)
find_program(CMAKE_LINKER armlink)
find_program(CMAKE_AR armar)
