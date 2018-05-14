# Based on https://github.com/Cethy/alpine-docker-client/blob/master/Dockerfile
FROM alpine:3.7 as downloader

ARG DOCKER_CLI_VERSION="17.03.0-ce"
ENV DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"

# install docker client
RUN apk --no-cache add curl \
    && curl -L $DOWNLOAD_URL | tar -xz docker \
    && mv docker/docker /usr/local/bin/docker


FROM scratch

COPY --from=downloader /usr/local/bin/docker /usr/local//bin/docker

ENTRYPOINT ["docker"]
CMD ["-v"]
