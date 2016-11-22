FROM dealii/full-deps:candi

MAINTAINER luca.heltai@gmail.com

# get deal.II repo
ARG VER=master
ARG BUILD_TYPE=Debug
ARG KEEP_SOURCE=false

RUN git clone https://github.com/dealii/dealii.git dealii-$VER-src && \
    cd dealii-$VER-src && \
    git checkout $VER && \
    mkdir build && cd build && \
    cmake -DDEAL_II_WITH_MPI=ON \
          -DDEAL_II_COMPONENT_EXAMPLES=OFF \
          -DCMAKE_INSTALL_PREFIX=~/dealii-$VER \
          -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
	  -GNinja \
          ../ && \
    ninja install && \
    ninja test && \
    ($KEEP_SOURCE && cd .. && rm -rf build .git) || \
    cd $HOME && rm -rf dealii-$VER-src

ENV DEAL_II_DIR ~/dealii-$VER
