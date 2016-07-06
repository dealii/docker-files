FROM ubuntu:trusty
# this is ubuntu 14.04

MAINTAINER timo.heister@gmail.com

# Set the locale
# this is required so that ASPECT can format numbers with , separators
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# add and enable user bob
RUN adduser --disabled-password --gecos '' bob
# RUN adduser bob sudo; echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chown -R bob:bob /home/bob
USER bob
ENV HOME /home/bob
WORKDIR $HOME


