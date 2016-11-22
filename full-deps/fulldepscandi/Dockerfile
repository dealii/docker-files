FROM dealii/base:gcc-mpi

MAINTAINER timo.heister@gmail.com

USER root
ADD candi/ $HOME/candi/
RUN chown -R $USER:$USER $HOME/candi/
USER $USER

RUN \
  cd candi && \
  ./candi.sh -j4 \
	--platform=deal.II-toolchain/platforms/supported/ubuntu16.platform \
	--prefix=$HOME/libs \
	--packages="load:dealii-prepare once:opencascade once:parmetis once:hdf5 once:p4est once:trilinos once:petsc once:slepc" &&\
  rm -rf $HOME/candi $HOME/libs/tmp

# I don't know how to import env vars from the configuration folder.  This
# probably doesn't work at all, because we don't use bash but sh and so we can
# not use 'source' or any of the bash startup files. Manually export the paths
# here instead:
RUN cat ~/libs/configuration/* | grep export

ENV HDF5_DIR=$HOME/libs/hdf5-1.8.15-patch1
ENV OPENCASCADE_DIR=$HOME/libs/oce-OCE-0.17
ENV METIS_DIR=$HOME/libs/parmetis-4.0.3
ENV PARMETIS_DIR=$HOME/libs/parmetis-4.0.3
ENV PETSC_DIR=$HOME/libs/petsc-3.6.4
ENV SLEPC_DIR=$HOME/libs/slepc-3.6.0
ENV TRILINOS_DIR=$HOME/libs/trilinos-12.4.2-Source
ENV P4EST_DIR=$HOME/libs/p4est-1.1
