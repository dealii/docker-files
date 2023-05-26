FROM ubuntu:jammy

LABEL maintainer="luca.heltai@gmail.com"

ARG VERSION=9.4.0-1ubuntu2~bpo22.04.1~ppa1
ARG REPO=ppa:ginggs/deal.ii-9.4.0-backports
ARG CLANG_VERSION=11
ARG CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.3.0/

USER root
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository $REPO \
    && apt-get update && apt-get install -y \
    git \
    libdeal.ii-dev=$VERSION \
    locales \
    ninja-build \
    numdiff \
    ssh \
    sudo \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN wget ${CLANG_REPO}/clang-format-${CLANG_VERSION}-linux.tar.gz \
    && tar xfv clang* && cp clang-${CLANG_VERSION}/bin/clang-format /usr/local/bin/ \
    && rm -rf clang*

# add and enable the default user
ARG USER=dealii
RUN adduser --disabled-password --gecos '' $USER
RUN adduser $USER sudo; echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# make sure everything is in place
RUN chown -R $USER:$USER /home/$USER
USER $USER
ENV HOME /home/$USER
ENV USER $USER
ENV OMPI_MCA_btl "^vader"
WORKDIR $HOME

