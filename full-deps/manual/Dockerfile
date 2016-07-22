FROM dealii/base

MAINTAINER luca.heltai@gmail.com
# based on work by Rene Gassmoeller and Timo Heister

# Set the locale, so that it's possible to format numbers with , sep
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

USER root

RUN apt-get update && apt-get -yq install \
    assimp-utils \
    bzip2 \
    clang \
    gsl-bin \
    libassimp-dev \
    libgsl0-dev \
    liblapack-dev \
    libopenmpi-dev \
    libtbb2 \
    libtbb-dev \
    libsuitesparse-dev \
    openmpi-bin \
    python 

# Make open mpi use clang
ENV OMPI_CC clang
ENV OMPI_CXX clang++
ENV CC mpicc
ENV CXX mpicxx
ENV FC mpif90
ENV FF mpif77

# The base system already contains everything that is needed.
ENV HOME /home/$USER
WORKDIR $HOME
USER $USER

#Build p4est
ENV P4EST_VERSION 1.1
RUN wget http://p4est.github.io/release/p4est-$P4EST_VERSION.tar.gz && \
    wget http://www.dealii.org/developer/external-libs/p4est-setup.sh && \
    chmod +x p4est-setup.sh && \
    ./p4est-setup.sh p4est-$P4EST_VERSION.tar.gz ~/libs/p4est-$P4EST_VERSION && \
    rm -rf p4est-build p4est-$P4EST_VERSION p4est-setup.sh p4est-$P4EST_VERSION.tar.gz
ENV P4EST_DIR $HOME/libs/p4est-$P4EST_VERSION 

#Build HDF5
ENV HDF5_VERSION 1.8.17
RUN wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-$HDF5_VERSION.tar.bz2 && \
    tar xjf hdf5-$HDF5_VERSION.tar.bz2 && \
    cd hdf5-$HDF5_VERSION &&  \
    ./configure --enable-parallel \
                --enable-shared \
                --prefix=$HOME/libs/hdf5-$HDF5_VERSION/ && \
    make -j2 && make install && \
    cd $HOME && \
    rm -rf hdf5-$HDF5_VERSION hdf5-$HDF5_VERSION.tar.bz2 
ENV HDF5_DIR $HOME/libs/hdf5-$HDF5_VERSION

#sundials
ENV SUNDIALS_VERSION 2.6.2
RUN wget https://github.com/luca-heltai/sundials/archive/v$SUNDIALS_VERSION.tar.gz &&\
    tar xf v$SUNDIALS_VERSION.tar.gz && rm -f v$SUNDIALS_VERSION.tar.gz && \
    cd sundials-$SUNDIALS_VERSION && \
    mkdir build && cd build && \
    cmake \
	-DCMAKE_INSTALL_PREFIX=$HOME/libs/sundials-$SUNDIALS_VERSION \
	-DLAPACK_ENABLE=ON \
	-DMPI_ENABLE=ON .. && \
    make -j4 && make install && \
    cd $HOME && \
    rm -rf sundials-$SUNDIALS_VERSION
    
ENV SUNDIALS_DIR $HOME/libs/sundials-$SUNDIALS_VERSION


#Build Trilinos
ENV TRILINOS_VERSION 12-6-3
RUN wget https://github.com/trilinos/Trilinos/archive/trilinos-release-$TRILINOS_VERSION.tar.gz && \
    tar xfz trilinos-release-$TRILINOS_VERSION.tar.gz && \
    mkdir Trilinos-trilinos-release-$TRILINOS_VERSION/build && \
    cd Trilinos-trilinos-release-$TRILINOS_VERSION/build && \
    cmake \
     -D BUILD_SHARED_LIBS=ON \
     -D CMAKE_BUILD_TYPE=RELEASE \
     -D CMAKE_CXX_FLAGS="-O3" \
     -D CMAKE_C_FLAGS="-O3" \
     -D CMAKE_FORTRAN_FLAGS="-O5" \
     -D CMAKE_INSTALL_PREFIX:PATH=$HOME/libs/trilinos-$TRILINOS_VERSION \
     -D CMAKE_VERBOSE_MAKEFILE=FALSE \
     -D TPL_ENABLE_Boost=OFF \
     -D TPL_ENABLE_MPI=ON \
     -D TPL_ENABLE_Netcdf:BOOL=OFF \
     -D TrilinosFramework_ENABLE_MPI:BOOL=ON \
     -D Trilinos_ASSERT_MISSING_PACKAGES:BOOL=OFF \
     -D Trilinos_ENABLE_ALL_OPTIONAL_PACKAGES:BOOL=ON \
     -D Trilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
     -D Trilinos_ENABLE_Amesos:BOOL=ON \
     -D Trilinos_ENABLE_AztecOO:BOOL=ON \
     -D Trilinos_ENABLE_Epetra:BOOL=ON \
     -D Trilinos_ENABLE_EpetraExt:BOOL=ON \
     -D Trilinos_ENABLE_Ifpack:BOOL=ON \
     -D Trilinos_ENABLE_Jpetra:BOOL=ON \
     -D Trilinos_ENABLE_Kokkos:BOOL=ON \
     -D Trilinos_ENABLE_Komplex:BOOL=ON \
     -D Trilinos_ENABLE_ML:BOOL=ON \
     -D Trilinos_ENABLE_MOOCHO:BOOL=ON \
     -D Trilinos_ENABLE_MueLu:BOOL=ON \
     -D Trilinos_ENABLE_OpenMP:BOOL=OFF \
     -D Trilinos_ENABLE_Piro:BOOL=ON \
     -D Trilinos_ENABLE_Rythmos:BOOL=ON \
     -D Trilinos_ENABLE_STK:BOOL=OFF \
     -D Trilinos_ENABLE_Sacado=ON \
     -D Trilinos_ENABLE_TESTS:BOOL=OFF \
     -D Trilinos_ENABLE_Stratimikos=ON \
     -D Trilinos_ENABLE_Teuchos:BOOL=ON \
     -D Trilinos_ENABLE_Thyra:BOOL=ON \
     -D Trilinos_ENABLE_Tpetra:BOOL=ON \
     -D Trilinos_ENABLE_TrilinosCouplings:BOOL=ON \
     -D Trilinos_EXTRA_LINK_FLAGS="-lgfortran" \
     -D Trilinos_VERBOSE_CONFIGURE=FALSE \
     .. && \
   make -j4 && make install && \
   cd $HOME && \
   rm -rf Trilinos-trilinos-release-* &&\
   rm -rf trilinos-release-*
ENV TRILINOS_DIR $HOME/libs/trilinos-$TRILINOS_VERSION

#petsc
ENV PETSC_VERSION 3.6.3
RUN wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-$PETSC_VERSION.tar.gz && \
    tar xf petsc-lite-$PETSC_VERSION.tar.gz && rm -f petsc-lite-$PETSC_VERSION.tar.gz && \
    cd petsc-$PETSC_VERSION && \
    ./configure \
	--download-fblaslapack=1 \
	--download-hypre=1  \
	--download-scalapack=1 \
	--download-mumps=1 \
	--download-metis \
	--download-parmetis \
	--download-superlu \
	--download-superlu_dist \
	--prefix=$HOME/libs/petsc-$PETSC_VERSION \
	--with-clanguage=C++ \
	--with-debugging=1 \
    	--with-shared-libraries=1 \
	--with-x=0 \
    	COPTFLAGS='-O3' FOPTFLAGS='-O3' && \
    make PETSC_DIR=`pwd` PETSC_ARC=docker all &&\
    make PETSC_DIR=`pwd` PETSC_ARC=docker install && \
    make PETSC_DIR=$HOME/libs/petsc-$PETSC_VERSION PETSC_ARCH= test && \
    cd && rm -rf petsc-$PETSC_VERSION

ENV PETSC_DIR $HOME/libs/petsc-$PETSC_VERSION
ENV METIS_DIR $PETSC_DIR
ENV SCALAPACK_DIR $PETSC_DIR
ENV PARMETIS_DIR $PETSC_DIR
ENV SUPERLU_DIR $PETSC_DIR
ENV SUPERLU_DIST_DIR $PETSC_DIR
ENV MUMPS_DIR $PETSC_DIR

#slepc
ENV SLEPC_VERSION 3.6.2
RUN wget http://slepc.upv.es/download/download.php?filename=slepc-$SLEPC_VERSION.tar.gz \
    -O slepc-$SLEPC_VERSION.tar.gz && \
    tar xfz slepc-$SLEPC_VERSION.tar.gz && rm -f slepc-$SLEPC_VERSION.rag.gz && \
    cd slepc-$SLEPC_VERSION && \
    ./configure --prefix=$HOME/libs/slepc-$SLEPC_VERSION && \
    make SLEPC_DIR=`pwd` && make SLEPC_DIR=`pwd` install && \
    cd && rm -rf slepc-$SLEPC_VERSION*

ENV SLEPC_DIR $HOME/libs/slepc-$SLEPC_VERSION    

#oce
ENV OCE_VERSION 0.17.1
RUN \
    wget https://github.com/tpaviot/oce/archive/OCE-$OCE_VERSION.tar.gz &&\
    tar xf OCE-$OCE_VERSION.tar.gz && rm -f OCE-$OCE_VERSION.tar.gz && \
    cd oce-OCE-$OCE_VERSION && \
    mkdir build && cd build && \
    cmake \
    -DOCE_INSTALL_PREFIX=$HOME/libs/oce-$OCE_VERSION \
    -DOCE_BUILD_SHARED_LIB:BOOL=ON \
    -DOCE_DATAEXCHANGE:BOOL=ON \
    -DOCE_DISABLE_X11:BOOL=ON \
    -DOCE_DRAW:BOOL=OFF \
    -DOCE_MODEL:BOOL=ON \
    -DOCE_MULTITHREAD_LIBRARY:STRING=NONE \
    -DOCE_OCAF:BOOL=ON \
    -DOCE_OSX_USE_COCOA:BOOL=ON \
    -DOCE_USE_TCL_TEST_FRAMEWORK:BOOL=OFF \
    -DOCE_VISUALISATION:BOOL=OFF \
    -DOCE_WITH_FREEIMAGE:BOOL=OFF \
    -DOCE_WITH_GL2PS:BOOL=OFF \
    -DOCE_WITH_OPENCL:BOOL=OFF \
    .. && \
    make -j4 && make install && \
    cd ../.. && rm -rf oce-*

ENV OPENCASCADE_DIR $HOME/libs/oce-$OCE_VERSION
ENV OCE_DIR $HOME/libs/oce-$OCE_VERSION

