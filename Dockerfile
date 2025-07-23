# Build grpc4bmi on a condaforge/miniforge3 base.
FROM csdms/bmi:0.2.0

LABEL author="Mark Piper"
LABEL email="mark.piper@colorado.edu"
LABEL organization="CSDMS"

RUN conda install -y \
    grpcio \
    grpcio-reflection \
    abseil-cpp \
    && conda clean --all -y

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
