ARG IMG=noble

FROM ubuntu:$IMG

ARG VERSION=9.6.0-1~ubuntu24.04.1~ppa1
ARG REPO=ppa:ginggs/deal.ii-9.6.0-backports

USER root
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository $REPO \
    && apt-get update && \
    apt-get install -y \
    git \
    libboost-dev \
    libboost-python-dev \
    libcgal-dev \
    libdeal.ii-dev=$VERSION \
    libflint-dev \
    libgmp-dev \
    libgtest-dev \
    libmpc-dev \
    locales \
    ninja-build \
    numdiff \
    python-is-python3 \
    python3-dev \
    python3-matplotlib \
    python3-pybind11 \
    python3-scipy\
    ssh \
    sudo \
    wget \
    && apt-get remove -y libdeal.ii-dev=$VERSION libcgal-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8

RUN wget https://raw.githubusercontent.com/dealii/dealii/refs/heads/master/contrib/utilities/download_clang_format \
    && chmod +x download_clang_format \
    && ./download_clang_format \
    && mv programs/clang-16/bin/clang-format /usr/local/bin/ \
    && rm -rf download_clang_format programs

# mold
# We require at least mold 2.32 to be able to link deal.II on ARM architectures.
# See also: https://github.com/dealii/dealii/pull/18172#issuecomment-2696956258
RUN cd /usr/src && \
    wget https://github.com/rui314/mold/archive/refs/tags/v2.36.0.tar.gz && \
    tar xvfz v2.36.0.tar.gz && rm v2.36.0.tar.gz && \
    cd mold-2.36.0 && \
    ./install-build-deps.sh && \
    mkdir build && cd build && \
    cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=c++ \
    -GNinja .. && \
    ninja && ninja install && \
    cd .. && rm -rf build

# Symengine
RUN cd /usr/src && \
    wget https://github.com/symengine/symengine/releases/download/v0.14.0/symengine-0.14.0.tar.gz && \
    tar xvfz symengine-0.14.0.tar.gz && rm symengine-0.14.0.tar.gz &&\
    cd symengine-0.14.0 && mkdir build && cd build && \
    cmake \
    -DBUILD_BENCHMARKS=off \
    -DBUILD_SHARED_LIBS=on \
    -DBUILD_TESTS=off \
    -DINTEGER_CLASS=flint \
    -DWITH_BOOST=on  \
    -DWITH_MPC=on \
    -DWITH_MPFR=on \
    -DWITH_SYMENGINE_THREAD_SAFE=on \
    -GNinja .. && \
    ninja && ninja install && \
    cd .. && rm -rf build

# CGAL
RUN cd /usr/src && \
    wget https://github.com/CGAL/cgal/releases/download/v5.6.2/CGAL-5.6.2.tar.xz && \
    tar xvf CGAL-5.6.2.tar.xz && \
    rm -rf CGAL-5.6.2.tar.xz  && \
    cd CGAL-5.6.2/  && \ 
    mkdir build && cd build && \
    cmake -GNinja .. -DCMAKE_INSTALL_PREFIX=/usr/ && \
    ninja install && cd ../ && rm -rf build 

# VTK
RUN cd /usr/src && \
    wget https://gitlab.kitware.com/vtk/vtk/-/archive/v9.4.0/vtk-v9.4.0.tar.gz && \
    tar xvf vtk-v9.4.0.tar.gz && \
    rm -rf vtk-v9.4.0.tar.gz && \
    cd vtk-v9.4.0/ && \ 
    mkdir build && cd build && \
    cmake -GNinja .. \
    -DCMAKE_INSTALL_PREFIX=/usr/ \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_TESTING=OFF \
    -DVTK_EXTRA_COMPILER_WARNINGS=OFF \
    -DVTK_GROUP_ENABLE_Imaging=DONT_WANT \
    -DVTK_GROUP_ENABLE_MPI=DONT_WANT \
    -DVTK_GROUP_ENABLE_Qt=DONT_WANT \
    -DVTK_GROUP_ENABLE_Rendering=DONT_WANT \
    -DVTK_GROUP_ENABLE_StandAlone=WANT \
    -DVTK_GROUP_ENABLE_Views=DONT_WANT \
    -DVTK_GROUP_ENABLE_Web=DONT_WANT \
    -DVTK_USE_MPI=OFF \
    -DVTK_WRAP_JAVA=OFF \
    -DVTK_WRAP_PYTHON=OFF && \
    ninja install && cd ../ && rm -rf build

RUN locale-gen en_US.UTF-8  
ENV LANG=en_US.UTF-8  

RUN ldconfig
ENV PYTHONPATH="/usr/local/lib/python3.8/site-packages/"

# add and enable the default user
ARG USER=dealii
ARG UID=1001
RUN adduser --disabled-password --gecos '' --uid $UID $USER
RUN adduser $USER sudo; echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# make sure everything is in place
RUN chown -R $USER:$USER /home/$USER
USER $USER
ENV HOME=/home/$USER
ENV USER=$USER
ENV OMPI_MCA_btl="^vader"
WORKDIR $HOME
