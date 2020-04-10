FROM dealii/ubuntu16

LABEL maintainer="timo.heister@gmail.com"

USER root
RUN apt-get update && apt-get -yq install \
    bzip2 \
    cmake \
    g++ \
    gcc \
    gfortran \
    git \
    gsl-bin \
    libblas-dev \
    libbz2-dev \
    libgsl-dev \
    liblapack-dev \
    libnetcdf-c++4-dev \
    libnetcdf-cxx-legacy-dev \
    libnetcdf-dev \
    ninja-build \
    numdiff \
    unzip \
    wget \
    zlib1g-dev


RUN \
    wget http://sourceforge.net/projects/astyle/files/astyle/astyle%202.04/astyle_2.04_linux.tar.gz && \
    tar xf astyle_2.04_linux.tar.gz && \
    cd astyle/build/gcc && \
    make && \
    USER=root make install && \
    cd - && \
    rm -rf astyle*

USER $USER
