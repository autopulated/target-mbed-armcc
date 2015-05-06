# Copyright (C) 2014-2015 ARM Limited. All rights reserved.
#message("mbedOS-GNU-C.cmake included")

if(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    set(ARMCC_ENV "")
else()
    set(ARMCC_ENV "LC_ALL=en_US.utf8 LANG=en_US.utf8")
endif()


# Override the link rules:
set(CMAKE_C_CREATE_SHARED_LIBRARY "echo 'shared libraries not supported' && 1")
set(CMAKE_C_CREATE_SHARED_MODULE  "echo 'shared modules not supported' && 1")
set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> -cr<LINK_FLAGS> <TARGET> <OBJECTS>")
set(CMAKE_C_COMPILE_OBJECT        "${ARMCC_ENV} <CMAKE_C_COMPILER> ${YOTTA_TARGET_DEFINITIONS} <DEFINES> --gnu -c <FLAGS> -o <OBJECT> <SOURCE>")
set(CMAKE_C_LINK_EXECUTABLE       "<CMAKE_LINKER> -o <TARGET> <OBJECTS> <LINK_LIBRARIES> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS>")
set(CMAKE_ASM_COMPILE_OBJECT      "${ARMCC_ENV} <CMAKE_C_COMPILER> ${YOTTA_TARGET_DEFINITIONS} <DEFINES> --gnu -c <FLAGS> -o <OBJECT> <SOURCE>")

set(CMAKE_C_FLAGS_DEBUG_INIT          "-O0 -g")
set(CMAKE_C_FLAGS_MINSIZEREL_INIT     "-Ospace -DNDEBUG")
set(CMAKE_C_FLAGS_RELEASE_INIT        "-Ospace -DNDEBUG")
set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "-Ospace -g -DNDEBUG")
set(CMAKE_INCLUDE_SYSTEM_FLAG_C "-isystem ")

set(CMAKE_ASM_FLAGS_DEBUG_INIT          "-O0 -g")
set(CMAKE_ASM_FLAGS_MINSIZEREL_INIT     "-O3 -Ospace -DNDEBUG")
set(CMAKE_ASM_FLAGS_RELEASE_INIT        "-O3 -Ospace -DNDEBUG")
set(CMAKE_ASM_FLAGS_RELWITHDEBINFO_INIT "-O3 -Ospace -g -DNDEBUG")
set(CMAKE_INCLUDE_SYSTEM_FLAG_ASM  "-isystem ")


# include paths for standard libs (use gcc's)
exec_program("${CMAKE_C_COMPILER} -print-libgcc-file-name" OUTPUT_VARIABLE _ARM_GNU_LIBGCC)
get_filename_component(_ARM_GNU_GCC_DIR ${CMAKE_C_COMPILER} DIRECTORY)
get_filename_component(_ARM_GNU_LIBGCC_DIR ${_ARM_GNU_LIBGCC} DIRECTORY)

# set link flags
set(CMAKE_C_LINK_FLAGS "")
set(CMAKE_MODULE_LINKER_FLAGS_INIT
    ""
)

# set the link script
set(CMAKE_EXE_LINKER_FLAGS_INIT
    "${CMAKE_MODULE_LINKER_FLAGS_INIT}"
) 

set(CMAKE_STATIC_LIBRARY_PREFIX "")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".ar")
set(CMAKE_EXECUTABLE_SUFFIX "")
set(CMAKE_C_OUTPUT_EXTENSION ".o")
set(CMAKE_C_RESPONSE_FILE_LINK_FLAG "--via=")
