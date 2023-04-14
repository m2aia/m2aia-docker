
all: mitk m2aia package vnc-base m2aia-vnc mitk-vnc qupath

mitk:
	@echo "Start MITK build"
	docker build $(ARGS) -t local/mitk:latest-build -f mitk-build/Dockerfile mitk-build/

m2aia:
	@echo "Start M2aia build"
	docker build $(ARGS) -t local/m2aia:latest-build -f m2aia-build/Dockerfile m2aia-build/

package:
	@echo "Start M2aia build package provider"
	docker build $(ARGS) -t ghcr.io/m2aia/m2aia:latest-package -f m2aia-package/Dockerfile m2aia-package/ 
	# docker push m2aia/m2aia:latest-package

vnc-base:
	@echo "Start no-vnc-base build package"
	docker build $(ARGS) -t local/m2aia:no-vnc-base -f m2aia-no-vnc-base/Dockerfile m2aia-no-vnc-base/

m2aia-vnc:
	@echo "Start M2aia no-vnc build package"
	docker build $(ARGS) -t ghcr.io/m2aia/m2aia:latest -f m2aia-no-vnc/Dockerfile m2aia-no-vnc/
	# docker push m2aia/m2aia:latest

mitk-vnc:
	@echo "Start Mitk no-vnc build package"
	docker build $(ARGS) -t ghcr.io/m2aia/mitk:latest -f mitk-no-vnc/Dockerfile mitk-no-vnc/
	# docker push m2aia/m2aia:latest

qupath:
	@echo "Start QuPath no-vnc build"
	docker build $(ARGS) -t ghcr.io/m2aia/qupath:0.4.3 -f qupath-no-vnc/Dockerfile qupath-no-vnc/
	# docker push m2aia/m2aia:latest

clear:
	docker rmi \
	  m2aia/m2aia:latest \
	  local/m2aia:no-vnc-base \
	  m2aia/m2aia:latest-package \
	  local/m2aia:latest-build \
	  local/mitk:latest-build