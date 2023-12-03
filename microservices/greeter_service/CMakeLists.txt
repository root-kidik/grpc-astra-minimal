cmake_minimum_required(VERSION 3.27.9)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(greeter_service)

# Grpc, protobuf library
include(../../cmake/GrpcTargets.cmake)
add_grpc_library(${PROJECT_NAME}_proto PROTOS test/greeter_service.proto
                 greeter_service1.proto)

# Service library
add_library(${PROJECT_NAME}_objs greeter_service.hpp greeter_service.cpp)
target_link_libraries(${PROJECT_NAME}_objs PUBLIC ${PROJECT_NAME}_proto)

# Service executable
add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE ${PROJECT_NAME}_objs)
