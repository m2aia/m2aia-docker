CONTAINER_REGISTRY=ghcr.io/
.PHONY: m2aia mitk ilastik qupath fiji vnc-base vnc-mitk build-mitk build-m2aia build-package


# Application builders
build-mitk:
	docker build $(ARGS) -t local.images/mitk/build build-mitk/

build-m2aia:
	docker build $(ARGS) -t local.images/m2aia/build build-m2aia/

build-package:
	docker build $(ARGS) -t  $(CONTAINER_REGISTRY)m2aia/m2aia:packages build-package/ 

# Base images for vnc access
vnc-base:
	docker build $(ARGS) -t local.images/no-vnc/base vnc-base/

vnc-mitk: vnc-base
	docker build $(ARGS) -t local.images/no-vnc/mitk vnc-mitk/

# Interactive NoVNC Applications
m2aia: vnc-mitk
	docker build $(ARGS) -t  $(CONTAINER_REGISTRY)m2aia/m2aia m2aia/

mitk: vnc-mitk
	docker build $(ARGS) -t  $(CONTAINER_REGISTRY)m2aia/mitk mitk/

qupath: vnc-base
	docker build $(ARGS) -t  $(CONTAINER_REGISTRY)m2aia/qupath qupath/

fiji: vnc-base
	docker build $(ARGS) -t  $(CONTAINER_REGISTRY)m2aia/fiji fiji/

ilastik: vnc-base
	docker build $(ARGS) -t  $(CONTAINER_REGISTRY)m2aia/ilastik ilastik/