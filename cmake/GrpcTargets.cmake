include_guard()

find_package(Protobuf CONFIG REQUIRED)
set(PROTOBUF_LIBPROTOBUF protobuf::libprotobuf)
set(REFLECTION gRPC::grpc++_reflection)
set(PROTOBUF_PROTOC $<TARGET_FILE:protobuf::protoc>)

find_package(gRPC CONFIG REQUIRED)
set(GRPC_GRPCPP gRPC::grpc++)
set(GRPC_CPP_PLUGIN_EXECUTABLE $<TARGET_FILE:gRPC::grpc_cpp_plugin>)

string(REGEX MATCH ".*\/" REPO_PATH "${CMAKE_CURRENT_LIST_DIR}")
file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/protos")

function(add_grpc_library name)
  set(options)
  set(oneValueArgs)
  set(multiValueArgs PROTOS)
  cmake_parse_arguments(GRPC_LIB "${options}" "${oneValueArgs}"
                        "${multiValueArgs}" ${ARGN})

  set(proto_paths)

  set(proto_hdrs)
  set(proto_srcs)
  set(grpc_hdrs)
  set(grpc_srcs)

  foreach(proto ${GRPC_LIB_PROTOS})
    get_filename_component(proto_path "${REPO_PATH}/protos/${proto}" ABSOLUTE)
    list(APPEND proto_paths "${proto_path}")

    string(REGEX REPLACE ".proto" "" proto_without_ext "${proto}")
    string(REGEX MATCH "([^\/]*)$" proto_name "${proto_without_ext}")
    string(REGEX MATCH ".*\/" proto_dir "${proto}")

    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/protos/${proto_dir}")
    message("${CMAKE_CURRENT_BINARY_DIR}/protos/${proto_dir}${proto_name}.pb.h")

    list(APPEND proto_hdrs
         "${CMAKE_CURRENT_BINARY_DIR}/protos/${proto_dir}${proto_name}.pb.h")
    list(APPEND proto_srcs
         "${CMAKE_CURRENT_BINARY_DIR}/protos/${proto_dir}${proto_name}.pb.cc")
    list(
      APPEND grpc_hdrs
      "${CMAKE_CURRENT_BINARY_DIR}/protos/${proto_dir}${proto_name}.grpc.pb.h")
    list(
      APPEND grpc_srcs
      "${CMAKE_CURRENT_BINARY_DIR}/protos/${proto_dir}${proto_name}.grpc.pb.cc")
  endforeach()

  add_custom_command(
    OUTPUT "${proto_hdrs}" "${proto_srcs}" "${grpc_hdrs}" "${grpc_srcs}"
    COMMAND
      "${PROTOBUF_PROTOC}" ARGS --grpc_out "${CMAKE_CURRENT_BINARY_DIR}/protos"
      --cpp_out "${CMAKE_CURRENT_BINARY_DIR}/protos" -I "${REPO_PATH}/protos"
      --plugin=protoc-gen-grpc="${GRPC_CPP_PLUGIN_EXECUTABLE}" "${proto_paths}"
    DEPENDS "${proto_paths}")

  add_library(${name} STATIC "${proto_hdrs}" "${proto_srcs}" "${grpc_hdrs}"
                             "${grpc_srcs}")
  target_link_libraries(${name} PUBLIC ${REFLECTION} ${GRPC_GRPCPP}
                                       ${PROTOBUF_LIBPROTOBUF})
  target_include_directories(${name}
                             PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/protos")
  set_target_properties(${name} PROPERTIES LINKER_LANGUAGE CXX)
endfunction()
