#pragma once

#include <grpcpp/grpcpp.h>
#include <grpcpp/support/status.h>

#include "echo_service.grpc.pb.h"
#include "echo_service.pb.h"

class EchoService final : public api::v1::EchoService::Service
{
public:
    grpc::Status Echo(grpc::ServerContext*, const api::v1::EchoRequest* request, api::v1::EchoResponse* reply) override;
};
