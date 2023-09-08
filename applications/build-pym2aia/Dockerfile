ARG M2AIA_VERSION
FROM ghcr.io/m2aia/packages:${M2AIA_VERSION} as packages

FROM ubuntu:22.04 as prepare

ENV M2AIA_PATH=/m2aia/bin/

ARG M2AIA_VERSION
ENV M2AIA_VERSION=${M2AIA_VERSION:-develop}


RUN mkdir -p /m2aia /pym2aia
COPY --from=packages /opt/packages/m2aia.tar.gz /tmp/m2aia.tar.gz
RUN tar -xzf /tmp/m2aia.tar.gz --strip 1 -C /m2aia/ && rm -rf /tmp/m2aia.tar.gz

RUN apt update
RUN apt install -y python3 python3-venv python3-pip git wget
RUN pip3 install wget

FROM prepare as build
RUN git clone https://github.com/m2aia/pym2aia /pym2aia
WORKDIR /pym2aia
RUN pip3 install -e .

# ENV M2AIA_DEBUG="ON"
RUN python3 setup_prepare.py
