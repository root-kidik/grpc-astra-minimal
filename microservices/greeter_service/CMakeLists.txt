cmake_minimum_required(VERSION 3.27.9)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(greeter_service)

grpc_generate(greeter_service)
