FROM  dockerhub.lemz.t/library/astralinux@sha256:a2a48e80b8c44bf3ef5d0097303c29d7cad5f3bdc4dc8e60a7417866842d8386

ARG NUM_JOBS=8

RUN apt-get update && apt-get install -y --no-install-recommends build-essential autoconf libtool pkg-config

RUN cd /tmp && git clone --recurse-submodules -b v1.58.0 --depth 1 --shallow-submodules https://github.com/grpc/grpc 
RUN cd /tmp/grpc && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DgRPC_INSTALL=ON \
        -DgRPC_BUILD_TESTS=OFF \
        -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
        ../.. && \
    make -j${NUM_JOBS} && \
    make install
