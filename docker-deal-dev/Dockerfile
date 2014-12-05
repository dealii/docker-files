FROM tjhei/deal-base

MAINTAINER timo.heister@gmail.com
# based on work by Rene Gassmoeller

# deal.II
RUN mkdir $HOME/deal.II && cd $HOME/deal.II && \
git clone https://github.com/dealii/dealii.git && \
mkdir build && cd build && \
    cmake -DDEAL_II_WITH_MPI=ON \
          -DDEAL_II_COMPONENT_EXAMPLES=OFF \
          -DCMAKE_INSTALL_PREFIX=~/deal.II/installed \
          -DCMAKE_BUILD_TYPE=Debug \
          -DP4EST_DIR=~/libs/p4est-0.3.4.2/ \
          -DTRILINOS_DIR=~/libs/trilinos-$TRILINOS_VERSION/ \
          -DHDF5_DIR=~/libs/hdf5/ \
          ../dealii && \
    make -j4 && make install

# && make clean 

