ARG M2AIA_VERSION
FROM local/images/m2aia/build:${M2AIA_VERSION} as source

FROM alpine:3.16.3 as build-packages
RUN mkdir -p /opt/packages
COPY --from=source /opt/packages/* /opt/packages/
