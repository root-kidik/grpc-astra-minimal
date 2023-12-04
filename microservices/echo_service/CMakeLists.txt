cmake_minimum_required(VERSION 3.27.9)

project(echo_service)

include(../../cmake/GrpcTargets.cmake)
add_grpc_library(${PROJECT_NAME}_proto PROTOS echo_service.proto)

add_library(${PROJECT_NAME}_objs src/echo_service.hpp src/echo_service.cpp)
target_link_libraries(${PROJECT_NAME}_objs PUBLIC ${PROJECT_NAME}_proto)

add_executable(${PROJECT_NAME} src/main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE ${PROJECT_NAME}_objs)
