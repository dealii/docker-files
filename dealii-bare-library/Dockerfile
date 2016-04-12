FROM dealii/dealii-base-system

MAINTAINER luca.heltai@gmail.com
# based on work by Rene Gassmoeller and Timo Heister

# deal.II repo
RUN mkdir $HOME/deal.II && cd $HOME/deal.II && \
    git clone https://github.com/dealii/dealii.git

#build
RUN cd deal.II && \
    mkdir build && cd build && \
    cmake -DDEAL_II_COMPONENT_EXAMPLES=OFF \
	   -DCMAKE_INSTALL_PREFIX=~/deal.II/installed \
          -DCMAKE_BUILD_TYPE=Debug \
          ../dealii && \
    make -j4 && make install && \
    cd .. && rm -rf build

ENV DEAL_II_DIR ~/deal.II/installed

# && make clean 

