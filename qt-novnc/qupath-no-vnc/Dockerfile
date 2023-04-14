FROM local/m2aia:no-vnc-base

LABEL IMAGE="qupath"
LABEL VERSION="0.4.3"


WORKDIR /src
RUN mkdir -p /qupath

# COPY --from=m2aia/m2aia:latest-package /opt/packages/mitk.tar.gz /src/mitk.tar.gz
# RUN tar -xzf /src/mitk.tar.gz --strip 1 -C /mitk/ && rm -rf /src/mitk.tar.gz

RUN wget https://github.com/qupath/qupath/releases/download/v0.4.3/QuPath-0.4.3-Linux.tar.xz -O /src/qupath.tar.xz && \
    tar -xvf /src/qupath.tar.xz --strip 1 -C /qupath/ && rm -rf /src/qupath.tar.gz

RUN sed -i 's/<title>M²aia Online<\/title>/<title>QuPath Online<\/title>/' /usr/local/lib/web/frontend/index.html
RUN chmod +x /qupath/bin/QuPath*

# Application start definition, here a shell script is used to start the application
COPY files/startQuPath.sh /root/Desktop/
RUN chmod 0777 /root/Desktop/startQuPath.sh
RUN ln -s /kaapana/mounted/mitk-data /root/Desktop/
WORKDIR /kaapana/mounted/mitk-data

# A supervisord config is used to make the application managed
COPY files/supervisord.conf /etc/supervisor/conf.d/
