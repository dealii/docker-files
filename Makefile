REPO=dealii

RELEASES=v8.5.0
DEPS=gcc-mpi-fulldepsmanual gcc-mpi-fulldepscandi clang-serial-bare
BUILDS=debugrelease

# General name is of the type $REPO/dealii:version-compiler-serialormpi-depstype-buildtype
# For example: dealii/dealii:v8.4.2-clang-mpi-fulldepsmanual-debug

# Use no-cache option to force rebuild
# DOCKER_BUILD=docker build --no-cache
DOCKER_BUILD=docker build

# A literal space
space :=
space +=

# Extract from the tag string what we need to compile
sec	 = $(subst $(space),-,$(wordlist $2,$3,$(subst -,$(space),$1)))
ver 	 = $(call sec,$1,1,1)
compiler = $(call sec,$1,2,3)
deps 	 = $(call sec,$1,4,4)
build	 = $(call sec,$1,5,5)
build_c	 = $(subst release,Release,$(subst debug,Debug,$(call build,$1)))

.SECONDARY:

# Base systems
locks/base-gcc-mpi: locks/base-gcc-serial
	$(DOCKER_BUILD) -t $(REPO)/base:gcc-mpi base/gcc-mpi
	touch $@

locks/base-clang-mpi: locks/base-clang-serial
	$(DOCKER_BUILD) -t $(REPO)/base:clang-mpi base/clang-mpi
	touch $@

locks/base-%: base/%/Dockerfile
	$(DOCKER_BUILD) -t $(REPO)/base:$* base/$*
	touch $@

base: $(foreach base, $(DEPS), locks/base-$(call sec,$(base),1,2))
	@echo "Built $?"

# Dependencies
locks/full-deps-bare:
	# this is only necessary to ensure compatibility of the Makefile
	touch $@
locks/full-deps-%: full-deps/%/Dockerfile
	$(DOCKER_BUILD) -t $(REPO)/full-deps:$* full-deps/$*
	touch $@

full-deps: $(foreach dep, $(DEPS), locks/full-deps-$(call sec,$(dep),3,3))
	@echo "Built $?"

# Deal.II systems
locks/dealii-%: 
	make locks/full-deps-$(call deps,$*)
	$(DOCKER_BUILD) -t $(REPO)/dealii:$* \
			--build-arg VER=$(call ver,$*) \
			--build-arg BUILD_TYPE=$(call build_c,$*) \
			dealii/$(call deps,$*)
	touch $@

dealii: $(foreach ver, $(RELEASES), \
	$(foreach dep, $(DEPS), \
	$(foreach build, $(BUILDS), \
	locks/dealii-$(ver)-$(dep)-$(build))))
	@echo "Built $?"

locks/indent:
	$(DOCKER_BUILD) -t $(REPO)/indent indent/
	touch $@

indent: locks/indent indent/Dockerfile Makefile
	@echo "Built $?"

# Push stage: base
push-base-%: locks/base-%
	docker push $(REPO)/base:$*

push-base: $(foreach base, $(DEPS), push-base-$(call sec,$(base),1,2))
	@echo "Push $?"

# Push stage: full-deps
push-full-deps-bare:
	@echo "Pushing bare deps (Nothing to do)"

push-full-deps-%: locks/full-deps-%
	docker push $(REPO)/full-deps:$*

push-full-deps: $(foreach dep, $(DEPS), push-full-deps-$(call sec,$(dep),3,3))
	@echo "Push $?"

# Push stage: dealii
push-dealii-%: locks/dealii-%
	docker push $(REPO)/dealii:$*

push-dealii: $(foreach ver, $(RELEASES), \
        $(foreach dep, $(DEPS), \
        $(foreach build, $(BUILDS), \
        push-dealii-$(ver)-$(dep)-$(build))))
	@echo "Push $?"

push-indent:
	docker push $(REPO)/indent

push: push-base push-full-deps push-dealii push-indent
	@echo "Pushing all."

all: base full-deps dealii
	@echo "Building all."

.PHONY: all push dealii full-deps base push-dealii push-full-deps push-base
