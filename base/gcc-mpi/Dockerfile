FROM dealii/base:gcc-serial

LABEL maintainer="luca.heltai@gmail.com"
# based on work by Rene Gassmoeller and Timo Heister

USER root

RUN apt-get update && apt-get -yq install \
    libmpich-dev \
    mpich \
    python

# Select the default compiler
ENV CC mpicc
ENV CXX mpicxx
ENV FC mpif90
ENV FF mpif77

# The base system already contains everything that is needed.
ENV HOME /home/$USER
WORKDIR $HOME
USER $USER
