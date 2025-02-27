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
DOCKER_BUILD=docker buildx build --push --platform linux/amd64,linux/arm64 --output type=registry
DOCKER_BUILD=docker buildx build --push --platform linux/arm64 --output type=registry


dependencies-jammy:
	$(DOCKER_BUILD) \
		-t dealii/dependencies:jammy \
		-t dealii/dependencies:jammy-v9.6.0 \
		--build-arg IMG=jammy \
                --build-arg VERSION=9.6.0-1~ubuntu22.04.1~ppa1 \
                --build-arg REPO=ppa:ginggs/deal.ii-9.6.0-backports \
                dependencies

dependencies-noble:
	$(DOCKER_BUILD) \
		-t dealii/dependencies:noble \
		-t dealii/dependencies:noble-v9.6.0 \
		-t dealii/dependencies:latest \
		--build-arg IMG=noble \
		--build-arg VERSION=9.6.0-1~ubuntu24.04.1~ppa1 \
		--build-arg REPO=ppa:ginggs/deal.ii-9.6.0-backports \
		dependencies

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
	dependencies-jammy \
	dependencies-noble \
	v9.5.0-jammy \
	v9.6.2-noble
