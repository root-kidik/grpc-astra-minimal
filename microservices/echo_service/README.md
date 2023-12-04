# 🔐 Echo 
Echo service

## 👾 Os 
- MacOS
- Linux
- Windows

## ⚙️ Configure
- Install [CMake](https://cmake.org/download)
- Install [gRPC](https://github.com/grpc/grpc/blob/v1.58.0/src/cpp/README.md)
- Install [protoc](https://grpc.io/docs/protoc-installation)

## 🔨 Build and Run 🚀
- `make build-debug` - debug build of the service with all the assertions and sanitizers enabled
- `make build-release` - release build of the service with LTO
- `make start-debug` - builds the service in debug mode and starts it
- `make start-release` - builds the service in release mode and starts it
- `make format` - autoformat all the C++ and Python sources
- `make analyze` - analyze code
- `make clean-` - cleans the object files
- `make dist-clean` - clean all, including the CMake cached configurations

## 🧿 Contracts
- [protobufs](../../protos)

## ⚒️ Tools
- Build generator: [CMake](https://cmake.org)
- Code formatter: [clang-format](https://clang.llvm.org/docs/ClangFormat.html)
- Code static analyzer: [clang-tidy](https://clang.llvm.org/extra/clang-tidy)

## 📚 Third party
- Contracts: [protobufs](https://protobuf.dev)
- RPC framework: [gRPC](https://grpc.io)
