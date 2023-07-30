FROM local/m2aia:no-vnc-base

LABEL IMAGE="qupath"
LABEL VERSION="0.4.3"


WORKDIR /src
RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# COPY --from=m2aia/m2aia:latest-package /opt/packages/mitk.tar.gz /src/mitk.tar.gz
# RUN tar -xzf /src/mitk.tar.gz --strip 1 -C /mitk/ && rm -rf /src/mitk.tar.gz

RUN wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip -O /src/fiji.zip && \
    unzip /src/fiji.zip -d / && mv /Fiji.app /fiji && rm -rf /src/fiji.zip

RUN sed -i 's/<title>M²aia Online<\/title>/<title>QuPath Online<\/title>/' /usr/local/lib/web/frontend/index.html
RUN chmod +x /fiji/ImageJ-linux64
RUN /fiji/ImageJ-linux64 --update update

# Application start definition, here a shell script is used to start the application
COPY files/startFiji.sh /root/Desktop/
RUN chmod 0777 /root/Desktop/startFiji.sh
RUN ln -s /data /root/Desktop/
WORKDIR /data

# A supervisord config is used to make the application managed
COPY files/supervisord.conf /etc/supervisor/conf.d/
