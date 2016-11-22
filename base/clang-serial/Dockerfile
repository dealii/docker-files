FROM dealii/ubuntu16

MAINTAINER luca.heltai@gmail.com
# based on work by Rene Gassmoeller and Timo Heister

USER root

RUN apt-get update && apt-get -yq install \
    bzip2 \
    clang \
    cmake \
    gfortran \
    git \
    gsl-bin \
    libblas-dev \
    libgsl0-dev \
    liblapack-dev \
    libsuitesparse-dev \
    libtbb-dev \
    libtbb2 \
    ninja-build \
    numdiff \
    python \
    unzip \
    wget 

# Export compilers
ENV CC clang
ENV CXX clang++
ENV FC gfortran
ENV FF gfortran

# Get astyle
RUN \
    wget http://sourceforge.net/projects/astyle/files/astyle/astyle%202.04/astyle_2.04_linux.tar.gz && \
    tar xf astyle_2.04_linux.tar.gz && \
    cd astyle/build/clang && \
    make && \
    USER=root make install && \
    cd - && \
    rm -rf astyle*

# The base system already contains everything that is needed.
ENV HOME /home/$USER
WORKDIR $HOME
USER $USER
