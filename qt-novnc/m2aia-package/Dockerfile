FROM alpine:3.16.3
RUN mkdir -p /opt/packages
COPY --from=local/m2aia:latest-build /opt/packages/* /opt/packages/
