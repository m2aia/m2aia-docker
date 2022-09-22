ARG BASE_IMAGE=ubuntu:latest

FROM ${BASE_IMAGE} as base


ENV CMAKE_VERSION_A=3.18
ENV CMAKE_VERSION_B=3.18.2

ENV BUILD_TESTING=OFF
ENV CMAKE_BUILD_TYPE=Release
ENV BUILD_M2AIA_CLI=ON
ENV BUILD_M2AIA=ON
ENV BUILD_MITK=OFF

WORKDIR /opt

# MITK BASE
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections 
RUN apt-get update
RUN apt-get install -q -y --no-install-recommends \
    build-essential \
    git \
    libglu1-mesa-dev \
    libtiff5-dev \
    libwrap0-dev \
    libxcomposite1 \
    libxcursor1 \
    libxi-dev \
    libxkbcommon-x11-0 \
    libxt-dev \
    mesa-common-dev \
    ca-certificates \
    curl \
    ninja-build \
    libasound2 \
    libnss3-dev \
    libnss3 \
    libnspr4-dev \
    libxtst6 \
    file \
    qtbase5-dev \
    qtscript5-dev \
    libqt5svg5-dev \
    libqt5opengl5-dev \
    libqt5xmlpatterns5-dev \
    qtwebengine5-dev \
    qttools5-dev \
    libqt5charts5-dev \
    libqt5x11extras5-dev \
    qtxmlpatterns5-dev-tools \
    libqt5webengine-data \
    libfontconfig1-dev \ 
    libdbus-1-3 \
    doxygen \
    libopenslide-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl --silent --location -o cmake-installer.sh https://cmake.org/files/v${CMAKE_VERSION_A}/cmake-${CMAKE_VERSION_B}-Linux-x86_64.sh  \
    && mkdir /opt/cmake \
    && chmod +x cmake-installer.sh \
    && sh ./cmake-installer.sh --prefix=/opt/cmake --skip-license \
    && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake \
    && ln -s /opt/cmake/bin/ccmake /usr/local/bin/ccmake \
    && rm cmake-installer.sh

# Configure M2aia
FROM base AS m2aia-config
RUN git clone https://github.com/jtfcordes/m2aia
RUN git clone https://github.com/mitk/mitk

WORKDIR /opt/mitk
RUN git checkout $(head -n 1 /opt/m2aia/mitk-version.info) && git apply /opt/m2aia/Patch/mitk.diff

RUN mkdir -p /opt/build
WORKDIR /opt/build
RUN cmake -G Ninja -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE} \
    -DBUILD_TESTING:BOOL=${BUILD_TESTING} \
    -DMITK_EXTENSION_DIRS:STRING=/opt/m2aia /opt/mitk
RUN cmake -DMITK_BUILD_CONFIGURATION=M2aiaRelease .

# # superbuild
FROM m2aia-config AS m2aia-build
RUN cmake --build . --target ITK
RUN cmake --build . --target VTK
RUN cmake --build . --target Boost

# M2aia build
WORKDIR /opt/m2aia
RUN git pull

WORKDIR /opt/build
RUN cmake --build .

# WORKDIR /opt/m2aia
# COPY files/add_exit.diff /opt/add_exit.diff
# RUN git apply ../add_exit.diff

# M2aia build
WORKDIR /opt/m2aia
RUN git pull
WORKDIR /opt/build/MITK-build
RUN cmake -DBUILD_M2aiaCLI_Export:BOOL=${BUILD_M2AIA_CLI} \
    -DMITK_BUILD_APP_M2aia:BOOL=${BUILD_M2AIA} \
    -DMITK_BUILD_APP_Workbench:BOOL=${BUILD_MITK} .
RUN cmake --build .

# M2aia package
RUN cmake --build . --target package
RUN mkdir -p /opt/packages
RUN mv *.tar.gz /opt/packages/m2aia.tar.gz
WORKDIR /opt/packages

VOLUME [ "/opt/packages" ]