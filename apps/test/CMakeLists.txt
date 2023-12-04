cmake_minimum_required(VERSION 3.27.9)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(test)

include(../../cmake/GrpcTargets.cmake)
add_grpc_library(${PROJECT_NAME}_proto PROTOS greeter_service.proto
                 echo_service.proto)

add_library(${PROJECT_NAME}_objs echo_client.hpp echo_client.cpp
                                 greeter_client.hpp greeter_client.cpp)
target_link_libraries(${PROJECT_NAME}_objs PUBLIC ${PROJECT_NAME}_proto)

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE ${PROJECT_NAME}_objs)
