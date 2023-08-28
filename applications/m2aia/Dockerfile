FROM local/images/no-vnc/mitk

# Add labels to identify the image and its version
LABEL IMAGE="m2aia"
LABEL VERSION="latest"

ARG ELASTIX_VERSION="5.0.0"
ENV ELASTIX_VERSION=$ELASTIX_VERSION

RUN sed -i 's/novnc2/M2aia Online/' /usr/local/lib/web/frontend/index.html

RUN mkdir -p /src /m2aia
RUN wget https://github.com/SuperElastix/elastix/releases/download/${ELASTIX_VERSION}/elastix-${ELASTIX_VERSION}-linux.tar.bz2 -O /src/elastix.tar.bz2
RUN tar -xvjf /src/elastix.tar.bz2 -C /usr/ && rm -rf /src/elastix.tar.bz2

COPY --from=ghcr.io/m2aia/m2aia:latest-package /opt/packages/m2aia.tar.gz /src/m2aia.tar.gz
RUN tar -xzf /src/m2aia.tar.gz --strip 1 -C /m2aia/ && rm -rf /src/m2aia.tar.gz

# Application start definition, here a shell script is used to start the application
COPY files/startM2aia.sh /root/Desktop/
RUN chmod 0777 /root/Desktop/startM2aia.sh

WORKDIR /data
# A supervisord config is used to make the application managed
COPY files/supervisord.conf /etc/supervisor/conf.d/



