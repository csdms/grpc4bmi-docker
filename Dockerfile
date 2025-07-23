# Build grpc4bmi from gRPC conda packages on a condaforge/miniforge3 base.
FROM csdms/bmi:0.2.1

LABEL author="Mark Piper"
LABEL email="mark.piper@colorado.edu"
LABEL organization="CSDMS"

# See https://github.com/csdms/grpc4bmi-docker/issues/1
RUN conda install -y \
    grpc-cpp \
    abseil-cpp \
    && conda clean --all -y

# See https://github.com/csdms/grpc4bmi-docker/issues/2
ENV base_url=https://github.com/csdms
ENV project=grpc4bmi
ENV prefix=/opt/${project}
RUN git clone --branch build-on-miniforge --depth 1 ${base_url}/${project} ${prefix}
WORKDIR ${prefix}
RUN git submodule update --init
WORKDIR ${prefix}/cpp/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    ctest && \
    make install && \
    make clean

WORKDIR /opt
