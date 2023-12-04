#pragma once

#include <grpcpp/grpcpp.h>

#include <memory>
#include <string>

#include "greeter_service.grpc.pb.h"

class GreeterClient
{
public:
    GreeterClient(const std::shared_ptr<grpc::Channel>& channel);

    std::string SayHello(const std::string& user);

private:
    std::unique_ptr<api::v1::GreeterService::Stub> _stub;
};
