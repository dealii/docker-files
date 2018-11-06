FROM dealii/base:clang-serial

MAINTAINER luca.heltai@gmail.com
# based on work by Rene Gassmoeller and Timo Heister

USER root

RUN apt-get update && apt-get -yq install \
    libmpich-dev \
    mpich

# Make open mpi use clang
ENV MPICH_CC clang
ENV MPICH_CXX clang++
ENV CC mpicc
ENV CXX mpicxx
ENV FC mpif90
ENV FF mpif77

# The base system already contains everything that is needed.
ENV HOME /home/$USER
WORKDIR $HOME
USER $USER
