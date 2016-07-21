REPO=dealii
BASE=candi manual bare
BUILDS=debug release debug-release

# Use no-cache option to force rebuild
# DOCKER_BUILD=docker build --no-cache
DOCKER_BUILD=docker build

locks/full-deps-bare:
	# this is only necessary to ensure compatibility of the Makefile
	touch $@

push-full-deps-bare:
	# this is only necessary to ensure compatibility of the Makefile
	echo "Nothing to do here."

locks/%-debug: dealii/%/Dockerfile locks/full-deps-%
	$(DOCKER_BUILD) -t $(REPO)/dealii:$*-debug --build-arg BUILD_TYPE=Debug dealii/$*
	touch $@

locks/%-release: dealii/%/Dockerfile locks/full-deps-%
	$(DOCKER_BUILD) -t $(REPO)/dealii:$*-release --build-arg BUILD_TYPE=Release dealii/$*
	touch $@

locks/%-debug-release: dealii/%/Dockerfile locks/full-deps-%
	$(DOCKER_BUILD) -t $(REPO)/dealii:$*-debug-release --build-arg BUILD_TYPE=DebugRelease dealii/$*
	touch $@

locks/full-deps-%: full-deps/%/Dockerfile
	$(DOCKER_BUILD) -t $(REPO)/full-deps:$* full-deps/$*
	touch $@
%: locks/%
	@echo "Preparing $@"

base: $(foreach base, $(BASE), full-deps-$(base))
	@echo "Built $?"

dealii: $(foreach base, $(BASE), $(foreach build, $(BUILDS), $(base)-$(build)))
	@echo "Built $?"

# Push stage
push-full-deps-%: locks/full-deps-%
	docker push $(REPO)/full-deps:$*

push-%: locks/%
	docker push $(REPO)/dealii:$*

push-base: $(foreach base, $(BASE), push-full-deps-$(base))
	@echo "Built $?"

push-dealii: $(foreach base, $(BASE), $(foreach build, $(BUILDS), push-$(base)-$(build)))
	@echo "Built $?"

all: push-base push-dealii

clean: 
	@rm -v locks/*
