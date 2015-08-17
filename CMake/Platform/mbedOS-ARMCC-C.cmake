# Copyright (C) 2014-2015 ARM Limited. All rights reserved.
#message("mbedOS-ARMCC-C.cmake included")

if(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    set(ARMCC_ENV "")
else()
    set(ARMCC_ENV "LC_ALL=en_US.utf8 LANG=en_US.utf8")
endif()

# Override the link rules:
set(CMAKE_C_CREATE_SHARED_LIBRARY "echo 'shared libraries not supported' && 1")
set(CMAKE_C_CREATE_SHARED_MODULE  "echo 'shared modules not supported' && 1")
set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> -cr<LINK_FLAGS> <TARGET> <OBJECTS>")
set(CMAKE_C_COMPILE_OBJECT        "${ARMCC_ENV} <CMAKE_C_COMPILER> <DEFINES> --gnu -c <FLAGS> -o <OBJECT> <SOURCE>")
set(CMAKE_C_LINK_EXECUTABLE       "<CMAKE_LINKER> -o <TARGET> <OBJECTS> <LINK_LIBRARIES> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS>")
# fun fact! armcc doesn't preprocess .S files on windows (that's uppercase .s)
# like gcc does (and like it does itself on Linux). So, we have to squeeze in
# an explicit preprocessing step here. We only do it on windows because it
# seems a bit risky...
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
    # to do && we need to put an explicit cmd.exe /C in here: This is how CMake
    # composes other composite commands for Ninja, so we should be safe
    set(CMAKE_ASM_COMPILE_OBJECT      "cmd.exe /C <CMAKE_C_COMPILER> <DEFINES> --gnu -E <FLAGS> -o <OBJECT>.pp.s <SOURCE> && <CMAKE_C_COMPILER> <DEFINES> --gnu --c90 -c <FLAGS> -o <OBJECT> <OBJECT>.pp.s")
else()
    set(CMAKE_ASM_COMPILE_OBJECT      "${ARMCC_ENV} <CMAKE_C_COMPILER> <DEFINES> --gnu -c <FLAGS> -o <OBJECT> <SOURCE>")
endif()

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

set(CMAKE_C_OUTPUT_EXTENSION ".o")
set(CMAKE_C_RESPONSE_FILE_LINK_FLAG "--via=")

