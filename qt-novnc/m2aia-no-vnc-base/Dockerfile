FROM dorowu/ubuntu-desktop-lxde-vnc:focal
#FROM no-vnc-bas-gpu:latest

LABEL IMAGE="m2aia-no-vnc-base"
LABEL VERSION="v2021.07.00"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libtiff5-dev \
    libwrap0-dev \
    libxcomposite1 \
    libxcursor1 \
    libxi-dev \
    libxkbcommon-x11-0 \
    mesa-common-dev \
    libssl-dev \
    wmctrl \
    libglu1-mesa-dev \
    freeglut3-dev \
    libxt-dev \
    libgomp1 \
    xvfb \
    qtbase5-dev \
    qtscript5-dev \
    libqt5svg5-dev \
    libqt5opengl5-dev \
    libqt5xmlpatterns5-dev \
    libqt5charts5-dev \
    qtwebengine5-dev \
    qttools5-dev \
    libqt5x11extras5-dev \
    qtxmlpatterns5-dev-tools \
    libqt5webengine-data \
    at-spi2-core  \
    gedit \
    libopenslide-dev \
    && rm -rf /var/lib/apt/lists/*

COPY files/startup.sh /startup.sh
COPY files/index.html /usr/local/lib/web/frontend/index.html
RUN chmod +x /startup.sh
