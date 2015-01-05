FROM tjhei/deal-base

MAINTAINER timo.heister@gmail.com
# based on work by Rene Gassmoeller

# deal.II repo
RUN mkdir $HOME/deal.II && cd $HOME/deal.II && \
    git clone https://github.com/dealii/dealii.git

#build
RUN cd deal.II && \
    cd dealii && git checkout dealii-8.2 && cd .. && \
    mkdir build && cd build && \
    cmake -DDEAL_II_WITH_MPI=ON \
          -DDEAL_II_COMPONENT_EXAMPLES=OFF \
          -DCMAKE_INSTALL_PREFIX=~/deal.II/installed \
          -DCMAKE_BUILD_TYPE=Debug \
          -DP4EST_DIR=~/libs/p4est-0.3.4.2/ \
	  -DPETSC_DIR=~/libs/petsc-3.4.5/ \
	  -DPETSC_ARCH=arch-linux2-cxx-debug \
          -DTRILINOS_DIR=~/libs/trilinos-$TRILINOS_VERSION/ \
          -DHDF5_DIR=~/libs/hdf5/ \
          ../dealii && \
    make -j4 && make install && \
    cd .. && rm -rf build

ENV DEAL_II_DIR ~/deal.II/installed
