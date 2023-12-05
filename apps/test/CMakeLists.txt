cmake_minimum_required(VERSION 3.22.6)

project(test)

include(../../cmake/GrpcTargets.cmake)
add_grpc_library(${PROJECT_NAME}_proto PROTOS greeter_service.proto
                 echo_service.proto)

add_library(${PROJECT_NAME}_objs src/echo_client.hpp src/echo_client.cpp
                                 src/greeter_client.hpp src/greeter_client.cpp)
target_link_libraries(${PROJECT_NAME}_objs PUBLIC ${PROJECT_NAME}_proto)

add_executable(${PROJECT_NAME} src/main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE ${PROJECT_NAME}_objs)
