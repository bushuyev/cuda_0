cmake_minimum_required(VERSION 3.18)

# Project name
project(test0 LANGUAGES CUDA CXX)

# Set the CUDA and C++ standards to C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 11)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

# Set GPU architecture (ensure compatibility with RTX 4090)
set(CMAKE_CUDA_ARCHITECTURES 89-real 89-virtual)

# Specify the target executable
add_executable(test0 test0.cu)


#set_property(TARGET test0 PROPERTY CUDA_ARCHITECTURES 89)

# Disable separable compilation
set_target_properties(test0 PROPERTIES
    CUDA_SEPARABLE_COMPILATION OFF
)

# Optionally, set the build type to Debug
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

# Enable verbose output (optional)
set(CMAKE_VERBOSE_MAKEFILE ON)

