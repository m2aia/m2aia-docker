ARG UBUNTU_VERSION=20.04
FROM ubuntu:${UBUNTU_VERSION}

ENV CMAKE_VERSION_A=3.18
ENV CMAKE_VERSION_B=3.18.2
ENV BUILD_TESTING=OFF
ENV CMAKE_BUILD_TYPE=Release

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
    qtmultimedia5-dev \
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

# Configure MITK
RUN mkdir -p /opt/mitk
RUN git clone https://github.com/m2aia/mitk-m2aia.git /opt/mitk
RUN git clone https://github.com/m2aia/mitk-elastix.git /opt/mitk-elastix
RUN git clone https://github.com/m2aia/mitk-docker.git /opt/mitk-docker

RUN mkdir -p /opt/build
WORKDIR /opt/build
RUN cmake -G Ninja \
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE} \
    -DBUILD_TESTING:BOOL=${BUILD_TESTING} \
    -DMITK_EXTENSION_DIRS:STRING='/opt/mitk-docker;/opt/mitk-elastix' \
    -DMITK_BUILD_CONFIGURATION=WorkbenchRelease \
    -DMITK_USE_MatchPoint:BOOL=ON \
    -S /opt/mitk \
    -B /opt/build
    
RUN cmake --build . --parallel --target ITK
RUN cmake --build . --parallel --target VTK
RUN cmake --build . --parallel

WORKDIR /opt/build/MITK-build/
RUN cmake --build . --target package

RUN mkdir -p /opt/packages
RUN cp /opt/build/MITK-build/*.tar.gz /opt/packages/mitk.tar.gz
RUN rm /opt/build/MITK-build/MITK*.tar.gz
