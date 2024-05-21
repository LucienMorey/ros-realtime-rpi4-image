set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

# force the python architure of the target.
set(PYTHON_SOABI cpython-310-aarch64-linux-gnu)
# This is really the important command see https://github.com/ros2/python_cmake_module/issues/9
# Note that the SOABI doesnt do anything anymore with newer versions of ROS2
set(PYTHON_MODULE_EXTENSION ".${PYTHON_SOABI}.so")

# TODO: this hard code is not great, but solving it comprehensively is kind of
# difficult (maybe dockcross? but that has its own drawbacks..)
set(CMAKE_SYSROOT /tmp/rpi4-image-build)

# Need to force pkg-config to look on the target sysroot instead of using local packages
set(PKG_CONFIG_EXECUTABLE ${CMAKE_CURRENT_LIST_DIR}/aarch64-linux-gnu-pkg-config CACHE STRING "Provide a pkg-config architecture wrapper")
set(triple aarch64-linux-gnu)
set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/lib/${triple}/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig")
set(ENV{PKG_CONFIG_DIR} "")
set(ENV{PKG_CONFIG_LIBDIR} "${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig")
set(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_SYSROOT})

# Assume host compiler, is that OK if host gcc version doesn't match target system gcc?
set(CMAKE_C_COMPILER /usr/bin/aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER /usr/bin/aarch64-linux-gnu-g++)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
