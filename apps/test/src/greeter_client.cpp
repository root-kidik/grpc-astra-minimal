#include "greeter_client.hpp"

#include <iostream>

GreeterClient::GreeterClient(const std::shared_ptr<grpc::Channel>& channel) :
_stub(api::v1::GreeterService::NewStub(channel))
{
}

std::string GreeterClient::SayHello(const std::string& user)
{
    api::v1::HelloRequest request;
    request.set_name(user);

    api::v1::HelloResponse response;
    grpc::ClientContext    context;
    grpc::Status           status = _stub->SayHello(&context, request, &response);

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
