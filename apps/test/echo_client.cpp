#include "echo_client.hpp"

#include <iostream>

EchoClient::EchoClient(const std::shared_ptr<grpc::Channel>& channel) : _stub(api::v1::EchoService::NewStub(channel))
{
}

std::string EchoClient::Echo(const std::string& message)
{
    api::v1::EchoRequest request;
    request.set_message(message);

    api::v1::EchoResponse response;
    grpc::ClientContext   context;
    grpc::Status          status = _stub->Echo(&context, request, &response);

    if (status.ok())
    {
        return response.message();
    }
    else
    {
        std::cout << status.error_code() << ": " << status.error_message() << std::endl;
        return "gRPC failed";
    }
}
