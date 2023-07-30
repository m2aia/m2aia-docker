FROM alpine:3.16.3
RUN mkdir -p /opt/packages
COPY --from=local.images/m2aia/build /opt/packages/* /opt/packages/
