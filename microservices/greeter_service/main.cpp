#include "greeter_service.hpp"

void RunServer()
{
    std::string    server_address("0.0.0.0:50051");
    GreeterService service;

    grpc::ServerBuilder builder;
    builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
    builder.RegisterService(&service);

    std::unique_ptr<grpc::Server> server(builder.BuildAndStart());
    std::cout << "Server listening on " << server_address << std::endl;

    server->Wait();
}

int main()
{
    RunServer();
}
