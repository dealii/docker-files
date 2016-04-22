FROM tjhei/dealii-base

MAINTAINER timo.heister@gmail.com

USER root
RUN apt-get update && sudo apt-get -yq install \
    gcc \
    clang \
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

USER bob

RUN git clone https://github.com/tjhei/candi; cd candi; git checkout experimental

ADD candi.cfg  $HOME/candi/
RUN \
  cd candi; \
  ./candi.sh -j4 --prefix=~/libs

# I don't know how to import env vars from the configuration folder.  This
# probably doesn't work at all, because we don't use bash but sh and so we can
# not use 'source' or any of the bash startup files. Manually export the paths
# here instead:
RUN cat ~/libs/configuration/* | grep export

ENV P4EST_DIR=/home/bob/libs/p4est-1.1
ENV HDF5_DIR=/home/bob/libs/hdf5-1.8.15-patch1
ENV PETSC_DIR=/home/bob/libs/petsc-3.6.3
ENV TRILINOS_DIR=/home/bob/libs/trilinos-12.4.2-Source

#RUN rm -rf ~/candi ~/libs/tmp




