ARG DOCKER_IMAGE_MITK_BUILD
FROM ${DOCKER_IMAGE_MITK_BUILD} as build-m2aia

ARG M2AIA_PACKAGE_VERSION
ENV M2AIA_PACKAGE_VERSION=${M2AIA_PACKAGE_VERSION}

RUN echo "Bulding M2aia Version: ${M2AIA_PACKAGE_VERSION}"

ENV BUILD_M2AIA_CLI=OFF
ENV BUILD_M2AIA_WORKBENCH=ON
ENV BUILD_MITK_WORKBENCH=OFF

ARG M2AIA_BRANCH
RUN mkdir -p /opt/m2aia
RUN git clone https://github.com/m2aia/m2aia -b ${M2AIA_BRANCH} /opt/m2aia

WORKDIR /opt/build
RUN cmake -DMITK_EXTENSION_DIRS:STRING='/opt/mitk-docker;/opt/mitk-elastix;/opt/m2aia' \
    -DM2AIA_PACKAGE_VERSION:STRING=${M2AIA_PACKAGE_VERSION} \
    .

RUN cmake -DMITK_BUILD_CONFIGURATION=M2aiaRelease .
RUN cmake --build .

WORKDIR /opt/build/MITK-build
RUN cmake \
    -DBUILD_M2aiaCLI_Export:BOOL=${BUILD_M2AIA_CLI} \
    -DMITK_BUILD_APP_M2aia:BOOL=${BUILD_M2AIA_WORKBENCH} \
    -DMITK_BUILD_APP_Workbench:BOOL=${BUILD_MITK_WORKBENCH} \
    -DM2AIA_PACKAGE_VERSION:STRING=${M2AIA_PACKAGE_VERSION} \
    .
    
RUN cmake --build .

# M2aia package
RUN cmake --build . --target package

RUN mkdir -p /opt/packages
RUN cp /opt/build/MITK-build/*.tar.gz /opt/packages/m2aia.tar.gz
