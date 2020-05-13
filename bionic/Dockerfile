FROM ubuntu:bionic

LABEL maintainer="luca.heltai@gmail.com"

USER root
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:ginggs/deal.ii-backports \
    && apt-get update && apt-get install -y \
    locales \
    git \
    ssh \
    wget \
    ninja-build \
    numdiff \
    libdeal.ii-dev \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN wget https://github.com/dealii/dealii/releases/download/v9.0.0/clang-format-6-linux.tar.gz \
    && tar xfv clang* && cp clang-6/bin/clang-format /usr/local/bin/ \
    && rm -rf clang*

# add and enable the default user
ARG USER=dealii
RUN adduser --disabled-password --gecos '' $USER
RUN adduser $USER sudo; echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#make sure everything is in place
RUN chown -R $USER:$USER /home/$USER
USER $USER
ENV HOME /home/$USER
ENV USER $USER
ENV OMPI_MCA_btl "^vader"
WORKDIR $HOME
