FROM dealii/full-deps:manual

MAINTAINER luca.heltai@gmail.com
# based on work by Timo Heister and Rene Gassmoeller

# Unzip
USER root
RUN apt-get install -y unzip
USER $USER

ARG BUILD_TYPE=Debug

# deal.II repo
RUN wget https://github.com/dealii/dealii/archive/master.zip &&\
    unzip master.zip && cd dealii-master &&\
    mkdir build && cd build && \
    cmake -GNinja \
	  -DDEAL_II_WITH_MPI=ON \
	  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
	  -DCMAKE_INSTALL_PREFIX=$HOME/libs/dealii-master \
          .. && \
    ninja -j1 && ninja install && \
    cd $HOME && rm -rf dealii-master && rm -f master.zip

ENV DEAL_II_DIR ~/libs/dealii-master
