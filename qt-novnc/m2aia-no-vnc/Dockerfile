FROM m2aia/m2aia-no-vnc-base

ARG ELASTIX_VERSION="5.0.0"
ENV ELASTIX_VERSION=$ELASTIX_VERSION

RUN mkdir -p /src /m2aia
RUN wget https://github.com/SuperElastix/elastix/releases/download/${ELASTIX_VERSION}/elastix-${ELASTIX_VERSION}-linux.tar.bz2 -O /src/elastix.tar.bz2
RUN tar -xvjf /src/elastix.tar.bz2 -C /usr/ && rm -rf /src/elastix.tar.bz2

# use github release
# RUN wget https://github.com/jtfcordes/M2aia/releases/download/v${M2AIA_BASE_VERSION}.00/M2aia-${M2AIA_BASE_VERSION}.${M2AIA_PATCH_VERSION}-linux-x86_64.tar.gz -O /src/m2aia.tar.gz

# use build image
COPY --from=m2aia/m2aia:latest-build /opt/packages/m2aia.tar.gz /src/m2aia.tar.gz
RUN tar -xzf /src/m2aia.tar.gz --strip 1 -C /m2aia/ && rm -rf /src/m2aia.tar.gz

# Application start definition, here a shell script is used to start the application
COPY files/startM2aia.sh /root/Desktop/
RUN chmod 0777 /root/Desktop/startM2aia.sh
RUN ln -s /data /root/Desktop/
WORKDIR /data

EXPOSE 80

# A supervisord config is used to make the application managed
COPY files/supervisord.conf /etc/supervisor/conf.d/