FROM dealii/full-deps:candi

MAINTAINER timo.heister@gmail.com

# get deal.II repo
RUN mkdir $HOME/deal.II && cd $HOME/deal.II && \
    git clone https://github.com/dealii/dealii.git

ARG VER=master
ARG BUILD_TYPE=Debug

RUN cd deal.II/dealii && \
    git checkout $VER

# now build and install
RUN cd deal.II && \
    mkdir build && cd build && \
    cmake -DDEAL_II_WITH_MPI=ON \
          -DDEAL_II_COMPONENT_EXAMPLES=OFF \
          -DCMAKE_INSTALL_PREFIX=~/deal.II/installed-$VER \
          -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
	  -GNinja \
          ../dealii && \
    ninja install && \
    ninja test && \
    cd .. && rm -rf build

ENV DEAL_II_DIR ~/deal.II/installed-$VER
