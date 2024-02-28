cmake_minimum_required(VERSION 3.24)
project(ZUC)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_LIST_DIR})

add_executable(ZUC Zmain.cpp ZUC.cpp ZUC_jm.cpp ZUC_wz.cpp)


# target_link_libraries(lab6 PRIVATE gtest gmock gtest_main)
