# ---------------------------------------------------------------------
#
# Copyright (C) 2020 by the deal.II authors
#
# This file is part of the deal.II library.
#
# The deal.II library is free software; you can use it, redistribute
# it, and/or modify it under the terms of the GNU Lesser General
# Public License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
# The full text of the license can be found in the file LICENSE.md at
# the top level directory of deal.II.
#
# ---------------------------------------------------------------------

# Use no-cache option to force rebuild
# DOCKER_BUILD=docker build --no-cache
DOCKER_BUILD=docker build

dependencies-jammy:
	$(DOCKER_BUILD) -t dealii/dependencies:jammy \
		--build-arg IMG=jammy \
                --build-arg VERSION=9.4.0-1ubuntu2~bpo22.04.1~ppa1 \
                --build-arg REPO=ppa:ginggs/deal.ii-9.4.0-backports \
                --build-arg CLANG_VERSION=11 \
                --build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.3.0/ \
                dependencies
	docker push dealii/dependencies:jammy
	docker tag dealii/dependencies:jammy dealii/dependencies:jammy-v9.4.0
	docker push dealii/dependencies:jammy-v9.4.0

dependencies-noble:
	$(DOCKER_BUILD) -t dealii/dependencies:noble \
		--build-arg IMG=noble \
		--build-arg VERSION=9.6.0-1~ubuntu24.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.6.0-backports \
		--build-arg CLANG_VERSION=16 \
		--build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.6.0/ \
		dependencies
	docker push dealii/dependencies:noble
	docker tag dealii/dependencies:noble dealii/dependencies:latest
	docker tag dealii/dependencies:noble dealii/dependencies:noble-v9.6.0
	docker push dealii/dependencies:noble
	docker push dealii/dependencies:latest

v9.5.0-jammy:
	$(DOCKER_BUILD) -t dealii/dealii:v9.5.0-jammy \
                --build-arg IMG=jammy \
                --build-arg VER=v9.5.0 \
                --build-arg PROCS=12 \
                github
	docker push dealii/dealii:v9.5.0-jammy
	docker tag dealii/dealii:v9.5.0-jammy dealii/dealii:latest
	docker push dealii/dealii:latest

v9.6.2-noble:
	$(DOCKER_BUILD) -t dealii/dealii:v9.6.2-noble \
		--build-arg IMG=noble \
		--build-arg VER=v9.6.2 \
		--build-arg PROCS=12 \
		github
	docker push dealii/dealii:v9.6.2-noble
	docker tag dealii/dealii:v9.6.2-noble dealii/dealii:latest
	docker push dealii/dealii:latest

all: dependencies-noble v9.6.2-noble

.PHONY: all \
	v9.1.1-bionic v9.2.0-bionic \
	v9.2.0-focal v9.3.0-focal v9.4.0-focal v9.4.1-focal v9.4.2-focal \
	v9.5.0-focal \
	v9.4.0-jammy v9.4.1-jammy v9.4.2-jammy \
	v9.5.0-jammy \
	dependencies-focal-v9.2.0 dependencies-focal-v9.3.0 dependencies-focal \
	dependencies-jammy
