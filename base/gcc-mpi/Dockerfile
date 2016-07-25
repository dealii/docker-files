FROM dealii/ubuntu14

MAINTAINER luca.heltai@gmail.com
# based on work by Rene Gassmoeller and Timo Heister

USER root

# Set the locale, so that it's possible to format numbers with , sep
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -yq install \
    bzip2 \
    cmake \
    gcc \
    g++ \
    gfortran \
    git \
    gsl-bin \
    libblas-dev \
    libgsl0-dev \
    liblapack-dev \
    libopenmpi-dev \
    libsuitesparse-dev \
    libtbb-dev \
    libtbb2 \
    ninja-build \
    numdiff \
    openmpi-bin \
    python \
    unzip \
    wget 

# The base system already contains everything that is needed.
ENV HOME /home/$USER
WORKDIR $HOME
USER $USER
