ARG M2AIA_VERSION="latest"
FROM ghcr.io/m2aia/packages:${M2AIA_VERSION} as packages

FROM local/images/no-vnc/mitk:${M2AIA_VERSION}

LABEL IMAGE="MitkOnline"
LABEL VERSION=${M2AIA_VERSION}
ENV ELASTIX_VERSION="5.0.0"

WORKDIR /src
RUN mkdir -p /mitk

RUN wget https://github.com/SuperElastix/elastix/releases/download/${ELASTIX_VERSION}/elastix-${ELASTIX_VERSION}-linux.tar.bz2 -O /src/elastix.tar.bz2
RUN tar -xvjf /src/elastix.tar.bz2 -C /usr/ && rm -rf /src/elastix.tar.bz2

COPY --from=packages /opt/packages/mitk.tar.gz /src/mitk.tar.gz
RUN tar -xzf /src/mitk.tar.gz --strip 1 -C /mitk/ && rm -rf /src/mitk.tar.gz

# RUN wget https://www.mitk.org/download/kaapana/workbench/MITK-v2022.10-linux-x86_64.tar.gz -O /src/mitk.tar.gz && \
#     tar -xzf /src/mitk.tar.gz --strip 1 -C /mitk/ && rm -rf /src/mitk.tar.gz
RUN sed -i 's/novnc2/MITK Online/' /usr/local/lib/web/frontend/index.html

# Application start definition, here a shell script is used to start the application
COPY files/startMITK.sh /root/Desktop/
RUN chmod 0777 /root/Desktop/startMITK.sh
RUN ln -s /data /root/Desktop/
WORKDIR /data

# A supervisord config is used to make the application managed
COPY files/supervisord.conf /etc/supervisor/conf.d/
