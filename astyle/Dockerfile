FROM ubuntu:14.04

MAINTAINER timo.heister@gmail.com

ENV HOME /root
WORKDIR /root

# Set the locale
# this is required so that ASPECT can format numbers with , separators
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -yq install \
    git \
    g++ \
    make \
    python \
    wget

RUN \
    wget http://sourceforge.net/projects/astyle/files/astyle/astyle%202.04/astyle_2.04_linux.tar.gz && \
    tar xf astyle_2.04_linux.tar.gz && \
    cd astyle/build/gcc && \
    make && \
    USER=root make install && \
    rm -rf /root/astyle*

     


