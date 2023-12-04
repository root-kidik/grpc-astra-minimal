cmake_minimum_required(VERSION 3.27.9)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(echo_service)

include(../../cmake/GrpcTargets.cmake)
add_grpc_library(${PROJECT_NAME}_proto PROTOS echo_service.proto)

add_library(${PROJECT_NAME}_objs echo_service.hpp echo_service.cpp)
target_link_libraries(${PROJECT_NAME}_objs PUBLIC ${PROJECT_NAME}_proto)

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE ${PROJECT_NAME}_objs)
