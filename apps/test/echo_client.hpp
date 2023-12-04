#pragma once

#include <grpcpp/grpcpp.h>

#include <memory>
#include <string>

#include "echo_service.grpc.pb.h"

class EchoClient
{
public:
    EchoClient(const std::shared_ptr<grpc::Channel>& channel);

    std::string Echo(const std::string& message);

private:
    std::unique_ptr<api::v1::EchoService::Stub> _stub;
};
