# ---------------------------------------------------------------------
#
# Copyright (C) 2020 - 2025 by the deal.II authors
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

ARCH=$(shell uname -m)
ifeq ($(ARCH),arm64)
PLATFORM=linux/arm64
else ifeq ($(ARCH),x86_64)
PLATFORM=linux/amd64
ARCH=amd64
endif

DOCKER_BUILD=docker buildx build --push --platform $(PLATFORM) --output type=registry

dependencies-jammy:
	$(DOCKER_BUILD) \
		-t dealii/dependencies:jammy-${ARCH} \
		-t dealii/dependencies:jammy-v9.7.1-${ARCH} \
		--build-arg IMG=jammy \
                --build-arg VERSION=9.7.1-1~ubuntu22.04.1~ppa1 \
                --build-arg REPO=ppa:ginggs/deal.ii-9.7.1-backports \
                ./dependencies

dependencies-noble:
	$(DOCKER_BUILD) \
		-t dealii/dependencies:noble-${ARCH} \
		-t dealii/dependencies:noble-v9.7.1-${ARCH} \
		-t dealii/dependencies:latest-${ARCH} \
		--build-arg IMG=noble \
		--build-arg VERSION=9.7.1-1~ubuntu24.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.7.1-backports \
		./dependencies

dependencies-resolute:
	$(DOCKER_BUILD) \
		-t dealii/dependencies:resolute-${ARCH} \
		-t dealii/dependencies:resolute-v9.7.1-${ARCH} \
		-t dealii/dependencies:latest-${ARCH} \
		--build-arg IMG=resolute \
		--build-arg VERSION=9.7.1-1~ubuntu26.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.7.1-backports \
		./dependencies

dependencies-%-merge::
	docker buildx imagetools create -t dealii/dependencies:$* \
		dealii/dependencies:$*-arm64 \
		dealii/dependencies:$*-amd64

%-merge::
	docker buildx imagetools create -t dealii/dealii:$* \
		dealii/dealii:$*-arm64 \
		dealii/dealii:$*-amd64

v9.7.1-resolute:
	$(DOCKER_BUILD) \
		-t dealii/dealii:v9.7.1-resolute-${ARCH} \
		-t dealii/dealii:latest-${ARCH} \
		--build-arg IMG=resolute \
		--build-arg VER=v9.7.1 \
		--build-arg NJOBS=12 \
		./dealii

v9.7.1-noble:
	$(DOCKER_BUILD) \
		-t dealii/dealii:v9.7.1-noble-${ARCH} \
		-t dealii/dealii:latest-${ARCH} \
		--build-arg IMG=noble \
		--build-arg VER=v9.7.1 \
		--build-arg NJOBS=12 \
		./dealii

v9.7.1-jammy:
	$(DOCKER_BUILD) \
		-t dealii/dealii:v9.7.1-jammy-${ARCH} \
		--build-arg IMG=jammy \
		--build-arg VER=v9.7.1 \
		--build-arg NJOBS=12 \
		./dealii

resolute: dependencies-resolute v9.7.1-resolute

noble: dependencies-noble v9.7.1-noble

jammy: dependencies-jammy v9.7.1-jammy

all: resolute jammy noble

.PHONY: all \
	dependencies-jammy \
	dependencies-noble \
	dependencies-resolute \
	dependencies-%-merge \
	%-merge \
	v9.7.1-jammy \
	v9.7.1-noble \
	v9.7.1-resolute
