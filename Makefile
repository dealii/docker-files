REPO=dealii
FULL_DEPS=candi manual bare
BASE=gcc-serial clang-mpi clang-serial
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

locks/base-%: base/%/Dockerfile
	$(DOCKER_BUILD) -t $(REPO)/base:$* base/$*
	touch $@

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

base: $(foreach base, $(BASE), base-$(base))
	@echo "Built $?"

full-deps: $(foreach base, $(FULL_DEPS), full-deps-$(base))
	@echo "Built $?"

dealii: $(foreach base, $(FULL_DEPS), $(foreach build, $(BUILDS), $(base)-$(build)))
	@echo "Built $?"

# Push stage
push-full-deps-%: locks/full-deps-%
	docker push $(REPO)/full-deps:$*

push-base-%: locks/base-%
	docker push $(REPO)/base:$*

push-full-deps: $(foreach full-deps, $(FULL_DEPS), push-full-deps-$(full-deps))
	@echo "Push $?"

push-dealii: $(foreach full-deps, $(FULL_DEPS), $(foreach build, $(BUILDS), push-$(full-deps)-$(build)))
	@echo "Push $?"

push-base: $(foreach base, $(BASE), push-base-$(base))
	@echo "Push $?"

push-%: locks/%
	docker push $(REPO)/dealii:$*

all: push-base push-full-deps push-dealii
	@echo "Pushing all."

clean: 
	@rm -v locks/*
