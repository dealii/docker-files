FROM ubuntu:14.04

MAINTAINER luca.heltai@gmail.com
# based on work by Rene Gassmoeller and Timo Heister

ENV HOME /root
WORKDIR /root

# Set the locale
# this is required so that ASPECT can format numbers with , separators
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# All packages required to build the library in parallel
RUN apt-get update && apt-get -yq install gcc \
    g++ \
    gfortran \
    libblas-dev \
    liblapack-dev \
    libopenmpi-dev \
    openmpi-bin \
    cmake \
    git \
    wget \
    python \
    numdiff \
    ninja-build

# The right version of astyle
RUN \
    wget http://sourceforge.net/projects/astyle/files/astyle/astyle%202.04/astyle_2.04_linux.tar.gz && \
    tar xf astyle_2.04_linux.tar.gz && \
    cd astyle/build/gcc && \
    make && \
    USER=root make install && \
    rm -rf /root/astyle*

