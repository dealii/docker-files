FROM ubuntu:focal

LABEL maintainer="luca.heltai@gmail.com"

ARG VERSION=9.3.0-1~ubuntu20.04.1~ppa1
ARG REPO=ppa:ginggs/deal.ii-9.3.0-backports
ARG CLANG_VERSION=11
ARG CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.3.0/

USER root
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository $REPO \
    && apt-get update && apt-get install -y \
    git \
    libboost-log1.71-dev \
    libboost-python-dev \
    libdeal.ii-dev=$VERSION \
    libflint-dev \
    libgmp-dev \
    libgtest-dev \
    libmpc-dev \
    llvm \
    locales \
    ninja-build \
    numdiff \
    python3-dev \
    python3-distutils \
    python3-matplotlib \
    python3-pybind11 \
    python3-scipy\
    ssh \
    sudo \
    wget \
    && apt-get remove -y libdeal.ii-dev=$VERSION \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN wget ${CLANG_REPO}/clang-format-${CLANG_VERSION}-linux.tar.gz \
    && tar xfv clang* && cp clang-${CLANG_VERSION}/bin/clang-format /usr/local/bin/ \
    && rm -rf clang*

# Symengine
RUN cd /usr/local/src && \
    wget https://github.com/symengine/symengine/releases/download/v0.8.1/symengine-0.8.1.tar.gz && \
    tar xvfz symengine-0.8.1.tar.gz && rm symengine-0.8.1.tar.gz &&\
    cd symengine-0.8.1 && mkdir build && cd build && \
    cmake \
    -DWITH_GMP=on \
    -DWITH_MPFR=on \
    -DWITH_MPC=on \
    -DINTEGER_CLASS=flint \
    -DWITH_LLVM=on \
    -DWITH_SYMENGINE_THREAD_SAFE=on \
    -DWITH_BOOST=on  \
    -GNinja .. && \
    ninja && ninja install && \
    cd .. && rm -rf build

# add and enable the default user
ARG USER=dealii
RUN adduser --disabled-password --gecos '' $USER
RUN adduser $USER sudo; echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#make sure everything is in place
RUN chown -R $USER:$USER /home/$USER
USER $USER
ENV HOME /home/$USER
ENV USER $USER
ENV OMPI_MCA_btl "^vader"
WORKDIR $HOME

