#include "echo_client.hpp"
#include "greeter_client.hpp"

void InterativeGRPC()
{
    {
        GreeterClient greeter(grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials()));
        std::string   user;
        std::cout << "Please enter your user name:\n";
        std::getline(std::cin, user);
        std::cout << greeter.SayHello(user) << "\n";
    }

    {
        EchoClient echo(grpc::CreateChannel("localhost:50052", grpc::InsecureChannelCredentials()));
        std::cout << "Type something\n";
        while (true)
        {
            std::string message;
            std::getline(std::cin, message);
            std::cout << echo.Echo(message) << "\n";
        }
    }
}

int main()
{
    InterativeGRPC();
}
