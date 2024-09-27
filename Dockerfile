# Build the grpc4bmi C++ environment on a mambaforge base.
FROM csdms/bmi:0.1.1

LABEL author="Mark Piper"
LABEL email="mark.piper@colorado.edu"
LABEL organization="CSDMS"

RUN mamba install -y grpcio abseil-cpp && \
    mamba clean --all -y

ENV base_url=https://github.com/csdms
ENV package=grpc4bmi
ENV prefix=/opt/${package}
RUN git clone --branch build-on-mambaforge --depth 1 ${base_url}/${package} ${prefix}
WORKDIR ${prefix}
RUN git submodule update --init
WORKDIR ${prefix}/cpp/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_PREFIX} && \
    make && \
    ctest && \
    make install && \
    make clean

WORKDIR /opt
