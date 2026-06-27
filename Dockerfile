FROM alpine:3.24

LABEL org.opencontainers.image.source="https://github.com/reanimus/dante-docker-ci"

# DANTE_VERSION is supplied by CI (the detected current version, identical
# across arches). For a local build, pass it explicitly, e.g.:
#   docker build --build-arg DANTE_VERSION="$(apk policy ...)" .
# or drop the "=${DANTE_VERSION}" pin for an unpinned local image.
ARG DANTE_VERSION
RUN apk add --no-cache "dante-server=${DANTE_VERSION}"

COPY sockd.conf /etc/sockd.conf

EXPOSE 1080

# sockd stays in the foreground without -D, which is what we want as PID 1.
CMD ["sockd", "-f", "/etc/sockd.conf"]
