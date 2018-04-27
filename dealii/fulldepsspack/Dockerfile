FROM dealii/full-deps:fulldepsspack

MAINTAINER luca.heltai@gmail.com

# get deal.II repo
USER       root
ARG 	   VER=develop
RUN        spack install -j12 dealii@$VER \
           && spack clean -a

USER 	   $USER
