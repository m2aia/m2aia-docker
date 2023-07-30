FROM local.images/no-vnc/base

RUN apt-get autoremove
RUN apt-get update --fix-missing
RUN apt-get install -y \
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

# COPY files/startup.sh /startup.sh
# COPY files/index.html /usr/local/lib/web/frontend/index.html
# RUN chmod +x /startup.sh
