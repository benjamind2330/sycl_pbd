FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    && apt-get clean

RUN add-apt-repository ppa:apt-fast/stable
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-fast \
    && apt-get clean

RUN apt-get update && \
    apt-fast install -y --no-install-recommends \
    cmake \
    curl \
    git \
    gnupg \
    libboost-all-dev \
    lsb-release \
    make \
    python3 \
    software-properties-common \
    wget \
    && apt-get clean

# Install llvm and clang
ARG CLANG_VERSION=19
# RUN  wget --no-check-certificate https://apt.llvm.org/llvm.sh && \
#      chmod +x llvm.sh && \
#      ./llvm.sh ${CLANG_VERSION}

# RUN apt-get update && \
# apt-get install -y --no-install-recommends \
#     libclang-${CLANG_VERSION}-dev \
#     clang-tools-${CLANG_VERSION} \
#     libomp-${CLANG_VERSION}-dev \
#     llvm-${CLANG_VERSION}-dev \
#     lld-${CLANG_VERSION} \
#     && apt-get clean

RUN apt-get update && \
apt-fast install -y --no-install-recommends \
    clang \
    libclang-dev \
    clang-tools \
    libomp-dev \
    llvm-dev \
    lld \
    && apt-get clean

RUN git clone https://github.com/AdaptiveCpp/AdaptiveCpp.git /opt/AdaptiveCpp && \
    cd /opt/AdaptiveCpp && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make install

LABEL Name=syclpbd Version=0.0.1
