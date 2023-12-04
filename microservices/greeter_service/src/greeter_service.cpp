#include "greeter_service.hpp"

grpc::Status GreeterService::SayHello(grpc::ServerContext*, const api::v1::HelloRequest* request, api::v1::HelloResponse* reply)
{
    std::string prefix("Hello ");
    reply->set_message(prefix + request->name() + "!");
    return grpc::Status::OK;
}
