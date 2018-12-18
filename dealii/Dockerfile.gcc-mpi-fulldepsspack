FROM dealii/full-deps:fulldepsspack

MAINTAINER luca.heltai@gmail.com

# get deal.II repo
USER       root

ARG 	   VER=develop
RUN        spack install dealii@$VER \
           && spack clean -a

RUN        echo "spack load dealii ninja numdiff cmake openmpi" \
           >> /etc/profile.d/spack.sh

USER 	   $USER
