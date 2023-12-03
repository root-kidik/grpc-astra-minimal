include_guard()

find_package(Protobuf CONFIG REQUIRED)
set(PROTOBUF_LIBPROTOBUF protobuf::libprotobuf)
set(REFLECTION gRPC::grpc++_reflection)
set(PROTOBUF_PROTOC $<TARGET_FILE:protobuf::protoc>)

find_package(gRPC CONFIG REQUIRED)
set(GRPC_GRPCPP gRPC::grpc++)
set(GRPC_CPP_PLUGIN_EXECUTABLE $<TARGET_FILE:gRPC::grpc_cpp_plugin>)

string(REGEX MATCH ".*\/" REPO_PATH "${CMAKE_CURRENT_LIST_DIR}")

function(add_grpc_library name)
  set(options)
  set(oneValueArgs)
  set(multiValueArgs PROTOS)
  cmake_parse_arguments(GRPC_LIB "${options}" "${oneValueArgs}"
                        "${multiValueArgs}" ${ARGN})

  set(proto_libs)

  foreach(proto ${GRPC_LIB_PROTOS})
    get_filename_component(proto_path "${REPO_PATH}/protos/${proto}" ABSOLUTE)
    string(REGEX REPLACE ".proto" "" proto_without_ext "${proto}")

    string(REGEX MATCH "([^\/]*)$" proto_name "${proto_without_ext}")
    string(REGEX MATCH ".*\/" proto_dir "${proto}")

    set(proto_hdrs "${CMAKE_CURRENT_BINARY_DIR}/${proto_dir}${proto_name}.pb.h")
    set(proto_srcs
        "${CMAKE_CURRENT_BINARY_DIR}/${proto_dir}${proto_name}.pb.cc")
    set(grpc_hdrs
        "${CMAKE_CURRENT_BINARY_DIR}/${proto_dir}${proto_name}.grpc.pb.h")
    set(grpc_srcs
        "${CMAKE_CURRENT_BINARY_DIR}/${proto_dir}${proto_name}.grpc.pb.cc")

    set(proto_lib "${proto_name}_lib")

    add_custom_command(
      OUTPUT "${proto_hdrs}" "${proto_srcs}" "${grpc_hdrs}" "${grpc_srcs}"
      COMMAND
        "${PROTOBUF_PROTOC}" ARGS --grpc_out
        "${CMAKE_CURRENT_BINARY_DIR}/${proto_dir}" --cpp_out
        "${CMAKE_CURRENT_BINARY_DIR}/${proto_dir}" -I
        "${REPO_PATH}/protos/${proto_dir}"
        --plugin=protoc-gen-grpc="${GRPC_CPP_PLUGIN_EXECUTABLE}" "${proto_path}"
      DEPENDS "${proto_path}")

    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${proto_dir}")

    add_library(${proto_lib} STATIC "${proto_hdrs}" "${proto_srcs}"
                                    "${grpc_hdrs}" "${grpc_srcs}")
    target_link_libraries(${proto_lib} PUBLIC ${REFLECTION} ${GRPC_GRPCPP}
                                              ${PROTOBUF_LIBPROTOBUF})
    target_include_directories(
      ${proto_lib} PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/${proto_dir}")

    list(APPEND proto_libs ${proto_lib})
  endforeach()

  add_library(${name} INTERFACE)
  target_link_libraries(${name} INTERFACE ${proto_libs})
endfunction()
