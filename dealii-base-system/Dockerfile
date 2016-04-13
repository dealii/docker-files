FROM ubuntu:14.04

MAINTAINER luca.heltai@gmail.com
# based on work by Rene Gassmoeller and Timo Heister

# Set the locale, so that it's possible to format numbers with , sep
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -yq install \
    cmake \
    g++ \
    gcc \
    git \
    gfortran \
    libblas-dev \
    liblapack-dev \
    libopenmpi-dev \
    ninja-build \
    numdiff \
    openmpi-bin \
    python \
    wget

# Install the right version of astyle as root
RUN \
    wget http://sourceforge.net/projects/astyle/files/astyle/astyle%202.04/astyle_2.04_linux.tar.gz && \
    tar xf astyle_2.04_linux.tar.gz && \
    cd astyle/build/gcc && \
    make && \
    USER=root make install && \
    rm -rf $HOME/astyle*


# End by adding a normal user, and switch to it
RUN useradd -m -c "Deal.II Library User" dealii  -s /bin/bash 
USER dealii
ENV HOME /home/dealii
WORKDIR /home/dealii
