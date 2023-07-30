FROM local/m2aia:no-vnc-base

LABEL IMAGE="ilastik"
LABEL VERSION="1.4.0"

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.7 \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/#Title#/ilastik Online/' /usr/local/lib/web/frontend/index.html
RUN mkdir -p /src /ilastik

RUN wget https://files.ilastik.org/ilastik-1.4.0-Linux.tar.bz2 -O /src/ilastik.tar.bz2 && \
    tar -xvf /src/ilastik.tar.bz2 --strip 1 -C /ilastik/ && rm -rf /src/ilastik.tar.bz2

RUN chmod +x /ilastik/run_ilastik.sh

# # Application start definition, here a shell script is used to start the application
COPY files/startIlastik.sh /root/Desktop/
RUN chmod 0777 /root/Desktop/startIlastik.sh

WORKDIR /data
# A supervisord config is used to make the application managed
COPY files/supervisord.conf /etc/supervisor/conf.d/
