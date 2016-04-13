FROM dealii/dealii-base-system

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

#Build p4est
ENV P4EST_VERSION 0.3.4.2
RUN wget http://p4est.github.io/release/p4est-$P4EST_VERSION.tar.gz && \
    wget http://www.dealii.org/developer/external-libs/p4est-setup.sh && \
    chmod +x p4est-setup.sh && \
    ./p4est-setup.sh p4est-$P4EST_VERSION.tar.gz ~/libs/p4est-$P4EST_VERSION && \
    rm -rf p4est-build p4est-$P4EST_VERSION p4est-setup.sh p4est-$P4EST_VERSION.tar.gz

#Build HDF5
ENV HDF_VERSION 1.8.16
RUN wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-$HDF_VERSION.tar.bz2 && \
    tar xjf hdf5-$HDF_VERSION.tar.bz2 && \
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
    tar xjf trilinos-$TRILINOS_VERSION-Source.tar.bz2 && \
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
    			  COPTFLAGS='-O3' FOPTFLAGS='-O3' && \
    make all

#sundials
ENV SUNDIALS_VERSION 2.6.2
ENV SUNDIALS_DIR $HOME/libs/sundials-$SUNDIALS_VERSION
RUN wget https://github.com/luca-heltai/sundials/archive/v$SUNDIALS_VERSION.tar.gz &&\
    tar xf v$SUNDIALS_VERSION.tar.gz && rm -f v$SUNDIALS_VERSION.tar.gz && \
    cd sundials-$SUNDIALS_VERSION && \
    mkdir build && cd build \
    cmake \
	-DCMAKE_INSTALL_PREFIX=$HOME/libs/sundials-$SUNDIALS_VERSION \
	-DLAPACK_ENABLE=ON \
	-DMPI_ENABLE=ON \
	-DPTHREAD_ENABLE=ON && \
    make -j4 && make install && \
    cd $HOME \
    rm -rf sundials-$SUNDIALS_VERSION
    
