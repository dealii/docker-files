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

RUN cat ~/libs/configuration/* | grep export

ENV P4EST_DIR=/home/bob/libs/p4est-1.1

#RUN rm -rf ~/candi ~/libs/tmp




