
cmake_minimum_required(VERSION 3.20)

project(test0 LANGUAGES CUDA CXX)

# Set the C++ and CUDA standards
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 11)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Set GPU architecture as needed for your GPU (e.g. RTX 4090)
set(CMAKE_CUDA_ARCHITECTURES 89)

# Optionally set build type to Debug if not provided
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

# Verbose makefile (optional)
set(CMAKE_VERBOSE_MAKEFILE ON)

# ---- Create a Shared Library from C++ and CUDA Code ----
# Assume util.cpp and util.cu contain utility functions you want to test
set_source_files_properties(util.cpp PROPERTIES LANGUAGE CUDA)
add_library(util STATIC util.cpp)
target_include_directories(util PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# ---- Create the Main CUDA Executable ----
add_executable(test0 test0.cu)
set_target_properties(test0 PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(test0 PRIVATE util)


# ---- Add GoogleTest via FetchContent ----
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)
# For Windows: prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

# ---- Add Test Executable for util Tests ----
add_executable(util_tests util_test.cpp)
set_target_properties(util PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(util_tests PRIVATE util GTest::gtest_main)
#target_link_libraries(util_tests GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(util_tests)

