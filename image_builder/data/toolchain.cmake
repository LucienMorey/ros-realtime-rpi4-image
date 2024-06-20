set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR riscv64)


# THIS ASSUMES COMPILER INSTALLED ON SYSTEM. IF ITS BEEN DOWNLOADED AND EXTRACTED ELSEWHERE UPDATE THE PATH!
# THERE MIGHT BE ISSUES WITH DIFFERENT VERSIONS OF GCC ON TEH HOST VS IN THE TARGET IMAGE SO BE AWARE OF THIS
set(CMAKE_C_COMPILER /usr/bin/riscv64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER /usr/bin/riscv64-linux-gnu-g++)

# This should be expressed without the decimal point, ie python 3.10 is 310 or 3.9 is 39
set(TARGET_PYTHON_VERSION 312)

# STUFF BELOW HERE SHOULDNT REALLY BE CHANGING BETWEEN TOOLCHAINS
set(TRIPLE ${CMAKE_SYSTEM_PROCESSOR}-linux-gnu)

# force the python architure of the target.
set(PYTHON_SOABI cpython-312-${TRIPLE})
# This is really the important command see https://github.com/ros2/python_cmake_module/issues/9
# Note that the SOABI doesnt do anything anymore with newer versions of ROS2
set(PYTHON_MODULE_EXTENSION ".${PYTHON_SOABI}.so")

# NOTE INHERITED FROM PREVIOUS CODEBASE - KINDA TRUE BUT ALSO DONT KNOW THAT IT MATTERS -LM 19/6/24
# TODO: this hard code is not great, but solving it comprehensively is kind of
# difficult (maybe dockcross? but that has its own drawbacks..)
set(CMAKE_SYSROOT /tmp/rpi4-image-build)

# Need to force pkg-config to look on the target sysroot instead of using local packages
set(PKG_CONFIG_EXECUTABLE ${CMAKE_CURRENT_LIST_DIR}/cross-linux-gnu-pkg-config CACHE STRING "Provide a pkg-config architecture wrapper")
set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/lib/${TRIPLE}/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig")
set(ENV{PKG_CONFIG_DIR} "")
set(ENV{PKG_CONFIG_LIBDIR} "${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig")
set(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_SYSROOT})

# stock standard for cross compilation. use local executalbes if required in the process but never local libs includes or packages for compilation, linking, etc
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Needs to be set so that multiple levels of shared object linking dont break
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
