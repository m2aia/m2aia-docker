FROM local.images/mitk/build

ARG BUILD_M2AIA_BRANCH
ENV BUILD_M2AIA_BRANCH=${BUILD_M2AIA_BRANCH:-main}


ENV BUILD_M2AIA_CLI=OFF
ENV BUILD_M2AIA_WORKBENCH=ON
ENV BUILD_MITK_WORKBENCH=OFF

RUN mkdir -p /opt/m2aia
RUN git clone https://github.com/m2aia/m2aia -b ${BUILD_M2AIA_BRANCH} /opt/m2aia

WORKDIR /opt/build
RUN cmake -DMITK_EXTENSION_DIRS:STRING='/opt/mitk-docker;/opt/mitk-elastix;/opt/m2aia' .
RUN cmake -DMITK_BUILD_CONFIGURATION=M2aiaRelease .
RUN cmake -DMITK_BUILD_DOCKER:BOOL=OFF 
RUN cmake --build .

WORKDIR /opt/build/MITK-build
RUN cmake \
    -DBUILD_M2aiaCLI_Export:BOOL=${BUILD_M2AIA_CLI} \
    -DMITK_BUILD_APP_M2aia:BOOL=${BUILD_M2AIA_WORKBENCH} \
    -DMITK_BUILD_APP_Workbench:BOOL=${BUILD_MITK_WORKBENCH} .
    
RUN cmake --build .

# M2aia package
RUN cmake --build . --target package

RUN mkdir -p /opt/packages
RUN cp /opt/build/MITK-build/*.tar.gz /opt/packages/m2aia.tar.gz