# Build grpc4bmi from gRPC conda packages on a condaforge/miniforge3 base.
FROM csdms/bmi:0.2.1

LABEL org.opencontainers.image.authors="Mark Piper <mark.piper@colorado.edu>"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/csdms/grpc4bmi"
LABEL org.opencontainers.image.source="https://github.com/csdms/grpc4bmi-docker"
LABEL org.opencontainers.image.vendor="CSDMS"

# See https://github.com/csdms/grpc4bmi-docker/issues/1
RUN conda install -y \
    libgrpc \
    libabseil \
    "protobuf>=4,<5" \
    libprotobuf \
    && conda clean --all -y

# See https://github.com/csdms/grpc4bmi-docker/issues/2
ENV base_url=https://github.com/csdms
ENV project=grpc4bmi
ENV version="0.6.0-csdms"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} --depth 1 ${base_url}/${project} ${prefix}
WORKDIR ${prefix}
RUN git submodule update --init
WORKDIR ${prefix}/cpp/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} -DCMAKE_CXX_STANDARD=17 && \
    make && \
    ctest && \
    make install && \
    make clean

WORKDIR /opt
