FROM tjhei/ubuntu14

MAINTAINER timo.heister@gmail.com

USER root
RUN apt-get update && sudo apt-get -yq install \
    gcc \
    g++ \
    gfortran \
    libblas-dev \
    liblapack-dev \
    cmake \
    git \
    wget \
    numdiff \
    ninja-build

RUN \
    wget http://sourceforge.net/projects/astyle/files/astyle/astyle%202.04/astyle_2.04_linux.tar.gz && \
    tar xf astyle_2.04_linux.tar.gz && \
    cd astyle/build/gcc && \
    make && \
    USER=root make install && \
    cd - && \
    rm -rf astyle*

USER bob

