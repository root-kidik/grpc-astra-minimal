#include "echo_service.hpp"

grpc::Status EchoService::Echo(grpc::ServerContext*, const api::v1::EchoRequest* request, api::v1::EchoResponse* reply)
{
    reply->set_message(request->message());
    return grpc::Status::OK;
}
