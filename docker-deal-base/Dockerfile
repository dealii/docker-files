FROM ubuntu:14.04

MAINTAINER timo.heister@gmail.com
# based on work by Rene Gassmoeller

ENV HOME /root

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

WORKDIR $HOME

#Build p4est
RUN wget http://p4est.github.io/release/p4est-0.3.4.2.tar.gz && \
    wget http://www.dealii.org/developer/external-libs/p4est-setup.sh && \
    chmod +x p4est-setup.sh && \
    ./p4est-setup.sh p4est-0.3.4.2.tar.gz ~/libs/p4est-0.3.4.2 && \
    rm -rf p4est-build p4est-0.3.4.2 p4est-setup.sh p4est-0.3.4.2.tar.gz

#Build HDF5
ENV HDF_VERSION 1.8.14
RUN wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-$HDF_VERSION.tar.bz2 && \
    tar xjvf hdf5-$HDF_VERSION.tar.bz2 && \
    cd hdf5-$HDF_VERSION &&  \
    ./configure --enable-parallel \
                --enable-shared \
                --prefix=$HOME/libs/hdf5/ && \
    make -j2 && make install && \
    cd $HOME && \
    rm -rf hdf5-$HDF_VERSION hdf5-$HDF_VERSION.tar.bz2 

#Build Trilinos
ENV TRILINOS_VERSION 11.8.1
RUN wget http://trilinos.sandia.gov/download/files/trilinos-$TRILINOS_VERSION-Source.tar.bz2 && \
    tar xjvf trilinos-$TRILINOS_VERSION-Source.tar.bz2 && \
    mkdir trilinos-$TRILINOS_VERSION-Source/build && \
    cd trilinos-$TRILINOS_VERSION-Source/build && \
    cmake -D Trilinos_ENABLE_Sacado=ON \
          -D Trilinos_ENABLE_Stratimikos=ON \
          -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_CXX_FLAGS="-O3" \
          -D CMAKE_C_FLAGS="-O3" \
          -D CMAKE_FORTRAN_FLAGS="-O5" \
          -D Trilinos_EXTRA_LINK_FLAGS="-lgfortran" \
          -D CMAKE_VERBOSE_MAKEFILE=FALSE \
          -D Trilinos_VERBOSE_CONFIGURE=FALSE \
          -D TPL_ENABLE_MPI=ON \
          -D BUILD_SHARED_LIBS=ON \
          -D CMAKE_INSTALL_PREFIX:PATH=$HOME/libs/trilinos-$TRILINOS_VERSION \
	  .. && \
	  make -j4 && make install && \
	  cd $HOME && \
	  rm -rf trilinos-$TRILINOS_VERSION-Source trilinos-$TRILINOS_VERSION-Source.tar.bz2 

#petsc
ENV PETSC_VERSION 3.4.5
RUN cd libs && wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-$PETSC_VERSION.tar.gz && \
    tar xf petsc-lite-$PETSC_VERSION.tar.gz && rm -f petsc-lite-$PETSC_VERSION.tar.gz && \
    cd petsc-$PETSC_VERSION && \
    export PETSC_DIR=`pwd` && \
    ./configure --download-scalapack=1 --download-mumps=1 --download-metis --download-parmetis --download-f-blas-lapack=1 \
    			  --with-shared-libraries=1 --with-clanguage=C++ --download-hypre=1  --with-x=0 --with-debugging=1 \
    			  COPTFLAGS='-O3 -march=native -mtune=native' FOPTFLAGS='-O3 -qarch=native -qtune=native' && \
    make all

