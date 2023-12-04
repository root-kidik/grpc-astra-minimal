#pragma once

#include <grpcpp/grpcpp.h>
#include <grpcpp/support/status.h>

#include "greeter_service.grpc.pb.h"
#include "greeter_service.pb.h"

class GreeterService final : public api::v1::GreeterService::Service
{
public:
    grpc::Status SayHello(grpc::ServerContext*, const api::v1::HelloRequest* request, api::v1::HelloResponse* reply) override;
};
