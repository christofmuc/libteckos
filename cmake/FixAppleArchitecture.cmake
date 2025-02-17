if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
    if (CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "x86_64")
        # Check whether we are running under Rosetta on arm64 hardware.
        execute_process(COMMAND sysctl -q hw.optional.arm64
                OUTPUT_VARIABLE _sysctl_stdout
                ERROR_VARIABLE _sysctl_stderr
                RESULT_VARIABLE _sysctl_result
                )
        if (_sysctl_result EQUAL 0 AND _sysctl_stdout MATCHES "hw.optional.arm64: 1")
            message(STATUS "Detected macOS m1 processor")
            set(CMAKE_HOST_SYSTEM_PROCESSOR arm64 CACHE INTERNAL "CMAKE_HOST_SYSTEM_PROCESSOR")
            set(QMAKE_APPLE_DEVICE_ARCHS arm64)
            if( CMAKE_CROSSCOMPILING )
                message(STATUS "Compiling multi build for x84_64 and arm64")
                set(CMAKE_OSX_ARCHITECTURES arm64 x86_64)
            else()
                message(STATUS "Compiling for arm64 only")
                set(CMAKE_OSX_ARCHITECTURES arm64)
            endif()
        else ()
            set(CMAKE_OSX_ARCHITECTURES x86_64)
        endif ()
    endif ()
endif ()