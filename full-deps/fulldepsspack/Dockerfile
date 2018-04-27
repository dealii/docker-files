FROM 	   dealii/ubuntu16

MAINTAINER luca.heltai@gmail.com

USER 	   root

# general environment for docker
ENV        DEBIAN_FRONTEND=noninteractive \
           SPACK_ROOT=/usr/local \
           FORCE_UNSAFE_CONFIGURE=1

# install minimal spack dependencies
RUN        apt-get update \
           && apt-get install -y --no-install-recommends \
              autoconf \
              ca-certificates \
              curl \
              environment-modules \
              git \
              build-essential \
	      gfortran \
              python \
              nano \
              unzip \
           && rm -rf /var/lib/apt/lists/*

# install spack
RUN        curl -s -L https://api.github.com/repos/spack/spack/tarball \
           | tar xzC $SPACK_ROOT --strip 1
RUN        echo ". $SPACK_ROOT/share/spack/setup-env.sh" \
           > /etc/profile.d/spack.sh

ADD 	   packages.yaml $SPACK_ROOT/etc/spack/packages.yaml

# install software
RUN 	   spack install -j12 --only=dependencies dealii@develop \
	   && spack clean -a

# switch to normal user
USER       $USER
