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
DOCKER_BUILD=docker buildx build --push --platform linux/amd64,linux/arm64 --output type=registry

# Repos:
# ppa:ginggs/deal.ii-backports
# ppa:ginggs/deal.ii-9.2.0-backports

# Version 9.1.1
v9.1.1-bionic:
	$(DOCKER_BUILD) -t dealii/dealii:v9.1.1-bionic \
		--build-arg VERSION=9.1.1-2~ubuntu18.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-backports \
		bionic
	docker push dealii/dealii:v9.1.1-bionic

# Version 9.2.0 - Change to the correct package when it is available
v9.2.0-bionic:
	$(DOCKER_BUILD) -t dealii/dealii:v9.2.0-bionic \
		--build-arg VERSION=9.2.0-1~ubuntu18.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.2.0-backports \
		bionic
	docker push dealii/dealii:v9.2.0-bionic

v9.2.0-focal:
	$(DOCKER_BUILD) -t dealii/dealii:v9.2.0-focal \
		--build-arg VERSION=9.2.0-1~ubuntu20.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.2.0-backports \
		--build-arg CLANG_VERSION=6 \
		--build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.0.0/ \
		focal
	docker push dealii/dealii:v9.2.0-focal

v9.3.0-focal:
	$(DOCKER_BUILD) -t dealii/dealii:v9.3.0-focal \
		--build-arg VERSION=9.3.0-1~ubuntu20.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.3.0-backports \
		--build-arg CLANG_VERSION=11 \
		--build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.3.0/ \
		focal
	docker push dealii/dealii:v9.3.0-focal
	docker tag dealii/dealii:v9.3.0-focal dealii/dealii:latest
	docker push dealii/dealii:latest

v9.4.0-focal:
	$(DOCKER_BUILD) -t dealii/dealii:v9.4.0-focal \
		--build-arg VERSION=9.4.0-1ubuntu2~bpo20.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.4.0-backports \
		--build-arg CLANG_VERSION=11 \
		--build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.3.0/ \
		focal
	docker push dealii/dealii:v9.4.0-focal
	docker tag dealii/dealii:v9.4.0-focal dealii/dealii:latest
	docker push dealii/dealii:latest

v9.4.0-jammy:
	$(DOCKER_BUILD) -t dealii/dealii:v9.4.0-jammy \
		--build-arg VERSION=9.4.0-1ubuntu2~bpo22.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.4.0-backports \
		--build-arg CLANG_VERSION=11 \
		--build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.3.0/ \
		jammy
	docker push dealii/dealii:v9.4.0-jammy

dependencies-focal-v9.2.0:
	$(DOCKER_BUILD) -t dealii/dependencies:focal-v9.2.0 \
 		--build-arg IMG=focal \
		--build-arg VERSION=9.2.0-1~ubuntu20.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.2.0-backports \
		--build-arg CLANG_VERSION=6 \
		--build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.0.0/ \
		dependencies
	docker push dealii/dependencies:focal-v9.2.0

dependencies-focal-v9.3.0:
	$(DOCKER_BUILD) -t dealii/dependencies:focal-v9.3.0 \
 		--build-arg IMG=focal \
		--build-arg VERSION=9.3.0-1~ubuntu20.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.3.0-backports \
		--build-arg CLANG_VERSION=11 \
		--build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.3.0/ \
		dependencies
	docker tag dealii/dependencies:focal dealii/dependencies:focal-v9.3.0
	docker push dealii/dependencies:focal-v9.3.0

dependencies-focal:
	$(DOCKER_BUILD) -t dealii/dependencies:focal \
		--build-arg IMG=focal \
                --build-arg VERSION=9.5.1-1~ubuntu20.04.1~ppa1 \
                --build-arg REPO=ppa:ginggs/deal.ii-9.5.1-backports \
                --build-arg CLANG_VERSION=16 \
                --build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.3.0/ \
                dependencies
	docker push dealii/dependencies:focal

dependencies-jammy:
	$(DOCKER_BUILD) \
		-t dealii/dependencies:jammy \
		-t dealii/dependencies:latest \
		--build-arg IMG=jammy \
                --build-arg VERSION=9.5.1-1~ubuntu22.04.1~ppa2 \
                --build-arg REPO=ppa:ginggs/deal.ii-9.5.1-backports \
                --build-arg CLANG_VERSION=16 \
                --build-arg CLANG_REPO=https://github.com/dealii/dealii/releases/download/v9.5.1/ \
                dependencies

v9.4.2-focal:
	$(DOCKER_BUILD) -t dealii/dealii:v9.4.2-focal \
		--build-arg IMG=focal \
		--build-arg VER=v9.4.2 \
		--build-arg PROCS=80 \
		github
	docker push dealii/dealii:v9.4.2-focal

v9.4.2-jammy:
	$(DOCKER_BUILD) -t dealii/dealii:v9.4.2-jammy \
		--build-arg IMG=jammy \
		--build-arg VER=v9.4.2 \
		--build-arg PROCS=80 \
		github
	docker push dealii/dealii:v9.4.2-jammy

v9.5.0-focal:
	$(DOCKER_BUILD) -t dealii/dealii:v9.5.0-focal \
                --build-arg IMG=focal \
                --build-arg VER=v9.5.0 \
                --build-arg PROCS=12 \
                github
	docker push dealii/dealii:v9.5.0-focal

v9.5.0-jammy:
	$(DOCKER_BUILD) -t dealii/dealii:v9.5.0-jammy \
                --build-arg IMG=jammy \
                --build-arg VER=v9.5.0 \
                --build-arg PROCS=12 \
                github
	docker push dealii/dealii:v9.5.0-jammy

v9.5.1-focal:
	$(DOCKER_BUILD) -t dealii/dealii:v9.5.1-focal \
                --build-arg IMG=focal \
                --build-arg VER=v9.5.1 \
                --build-arg PROCS=12 \
                github
	docker push dealii/dealii:v9.5.1-focal

v9.5.1-jammy:
	$(DOCKER_BUILD) \
		-t dealii/dealii:v9.5.1-jammy \
		-t dealii/dealii:latest \
                --build-arg IMG=jammy \
                --build-arg VER=v9.5.1 \
                --build-arg PROCS=12 \
                github

all: dependencies-focal v9.5.0-focal dependencies-jammy v9.5.0-jammy 

.PHONY: all \
	v9.1.1-bionic v9.2.0-bionic \
	v9.2.0-focal v9.3.0-focal v9.4.0-focal v9.4.1-focal v9.4.2-focal \
	v9.5.0-focal \
	v9.4.0-jammy v9.4.1-jammy v9.4.2-jammy \
	v9.5.0-jammy \
	dependencies-focal-v9.2.0 dependencies-focal-v9.3.0 dependencies-focal \
	dependencies-jammy
