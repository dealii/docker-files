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

# Version 9.1.1
v9.1.1-bionic:
	$(DOCKER_BUILD) -t dealii/dealii:v9.1.1-bionic \
		--build-arg VERSION=9.1.1-2~ubuntu18.04.1~ppa1 \
		bionic
	docker push dealii/dealii:v9.1.1-bionic
	# Move the next two lines below 9.2 is updated
	docker tag dealii/dealii:v9.1.1-bionic dealii/dealii:latest
	docker push dealii/dealii:latest

# # Version 9.2.0 - Change to the correct package when it is available
# v9.2.0-bionic:
#	IMG=dealii/dealii:v9.2.0-bionic 
#	$(DOCKER_BUILD) -t $(IMG) \
#		--build-arg VERSION=9.2.0-1~ubuntu18.04.1~ppa1 \
#		bionic
#	docker push $(IMG)
#	docker tag $(IMG) dealii/dealii:latest
#	docker push dealii/dealii:latest

all: v9.1.1-bionic

.PHONY: all v9.1.1-bionic
