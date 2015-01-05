FROM tjhei/deal82

MAINTAINER timo.heister@gmail.com

RUN apt-get install -yq clang

RUN cd deal.II && \
    cd dealii && git checkout dealii-8.2 && cd .. && \
    mkdir buildclang && cd buildclang && \
    CXX=clang++ CC=clang \
    cmake -D DEAL_II_CXX_FLAGS_DEBUG="-O1 -fsanitize=address -fno-omit-frame-pointer -Wlogical-op-parentheses" \
          -DDEAL_II_WITH_MPI=ON \
          -DDEAL_II_COMPONENT_EXAMPLES=OFF \
          -DCMAKE_INSTALL_PREFIX=~/deal.II/installedclang \
          -DCMAKE_BUILD_TYPE=Debug \
          -DP4EST_DIR=~/libs/p4est-0.3.4.2/ \
          -DPETSC_DIR=~/libs/petsc-3.4.5/ \
          -DPETSC_ARCH=arch-linux2-cxx-debug \
          -DTRILINOS_DIR=~/libs/trilinos-11.8.1/ \
          -DHDF5_DIR=~/libs/hdf5/ \
          ../dealii && \
    make -j4 && make install && \
    cd .. && rm -rf buildclang
