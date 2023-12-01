function(add_grpc_library proto_file proto_src)
  find_package(Protobuf CONFIG REQUIRED)

  set(PROTOBUF_LIBPROTOBUF protobuf::libprotobuf)
  set(REFLECTION gRPC::grpc++_reflection)
  set(PROTOBUF_PROTOC $<TARGET_FILE:protobuf::protoc>)

  find_package(gRPC CONFIG REQUIRED)

  set(GRPC_GRPCPP gRPC::grpc++)
  set(GRPC_CPP_PLUGIN_EXECUTABLE $<TARGET_FILE:gRPC::grpc_cpp_plugin>)
  
  get_filename_component(proto "protos/${proto_name}.proto" ABSOLUTE)
  get_filename_component(proto_dir "${proto}" DIRECTORY)

  set(proto_srcs "${CMAKE_CURRENT_BINARY_DIR}/${proto_name}.pb.cc")
  set(proto_hdrs "${CMAKE_CURRENT_BINARY_DIR}/${proto_name}.pb.h")
  set(grpc_srcs "${CMAKE_CURRENT_BINARY_DIR}/${proto_name}.grpc.pb.cc")
  set(grpc_hdrs "${CMAKE_CURRENT_BINARY_DIR}/${proto_name}.grpc.pb.h")

  add_custom_command(
    OUTPUT "${proto_srcs}" "${proto_hdrs}" "${grpc_srcs}" "${grpc_hdrs}"
    COMMAND ${PROTOBUF_PROTOC}
    ARGS 
    --grpc_out "${CMAKE_CURRENT_BINARY_DIR}"
    --cpp_out "${CMAKE_CURRENT_BINARY_DIR}"
    -I "${proto_dir}"
    --plugin=protoc-gen-grpc="${GRPC_CPP_PLUGIN_EXECUTABLE}"
    "${proto}"
    DEPENDS "${proto}"
  )

  include_directories(${CMAKE_CURRENT_BINARY_DIR})

  add_library(${proto_name} ${proto_srcs} ${grpc_srcs})
  target_link_libraries(${proto_name} PUBLIC ${REFLECTION} ${GRPC_GRPCPP} ${PROTOBUF_LIBPROTOBUF})
endfunction()
