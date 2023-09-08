.PHONY: m2aia mitk ilastik qupath fiji vnc-base vnc-mitk build-mitk build-m2aia build-package publish

# Make arguments
# CR_PAT => registry access token
# CR_USERNAME => registry user name
# CR_URL => url of the registry
# M2AIA_VERSION => version tag e.g. v2023.08
# M2AIA_BRANCH => branch@https://github.com/m2aia/m2aia
# DOCKER_BUILD_ARGS => e.g. run "make publish DOCKER_BUILD_ARGS=--no-cache"

CR_URL?=ghcr.io/
CR_USERNAME?=
CR_PAT?=
M2AIA_VERSION?=latest
M2AIA_BRANCH?=develop
DOCKER_BUILD_ARGS?=

# Application builders
build-mitk:
	docker build $(DOCKER_BUILD_ARGS) -t local/images/mitk/build:$(M2AIA_VERSION) build-mitk/

build-m2aia: build-mitk
	docker build $(DOCKER_BUILD_ARGS) --build-arg M2AIA_VERSION=$(M2AIA_VERSION) --build-arg BUILD_M2AIA_BRANCH=$(M2AIA_BRANCH) -t local/images/m2aia/build:$(M2AIA_VERSION) build-m2aia/

build-package: build-m2aia
	docker build $(DOCKER_BUILD_ARGS) --build-arg M2AIA_VERSION=$(M2AIA_VERSION) -t $(CR_URL)m2aia/packages:$(M2AIA_VERSION) build-package/ 

build-pym2aia: build-package
	docker build $(DOCKER_BUILD_ARGS) --build-arg M2AIA_VERSION=$(M2AIA_VERSION) -t $(CR_URL)m2aia/pym2aia:$(M2AIA_VERSION) build-pym2aia/ 

# Base images for vnc access
vnc-base:
	docker build $(DOCKER_BUILD_ARGS) -t local/images/no-vnc/base:$(M2AIA_VERSION) vnc-base/

vnc-mitk: vnc-base
	docker build $(DOCKER_BUILD_ARGS) -t local/images/no-vnc/mitk:$(M2AIA_VERSION) vnc-mitk/

# Interactive NoVNC Applications
m2aia: vnc-mitk build-package
	docker build $(DOCKER_BUILD_ARGS) --build-arg M2AIA_VERSION=$(M2AIA_VERSION) -t $(CR_URL)m2aia/m2aia:$(M2AIA_VERSION) m2aia/

mitk: vnc-mitk build-package
	docker build $(DOCKER_BUILD_ARGS) --build-arg M2AIA_VERSION=$(M2AIA_VERSION) -t $(CR_URL)m2aia/mitk:$(M2AIA_VERSION) mitk/

qupath: vnc-base
	docker build $(DOCKER_BUILD_ARGS) -t $(CR_URL)m2aia/qupath qupath/

fiji: vnc-base
	docker build $(DOCKER_BUILD_ARGS) -t $(CR_URL)m2aia/fiji fiji/

ilastik: vnc-base
	docker build $(DOCKER_BUILD_ARGS) -t $(CR_URL)m2aia/ilastik ilastik/

# Publish 
publish: mitk m2aia
	@echo $(CR_PAT) | docker login ghcr.io -u $(CR_USERNAME) --password-stdin
	docker push $(CR_URL)m2aia/m2aia:$(M2AIA_VERSION)
	docker push $(CR_URL)m2aia/mitk:$(M2AIA_VERSION)