# docker-client

Docker image to serve as a minimal container for running docker client commands.
It is based on `scratch` and contains only the docker client binary, that is it.

_NOTE: This work is derived from https://github.com/Cethy/alpine-docker-client._

## Contents

- docker client binary: Allows for running docker commands against a docker daemon.

## Usage

```bash
docker run \
  -v /var/run/docker.sock:/var/run/docker.sock \
  timberio/docker-client version
```

```text
Client:
 Version:      18.03.1-ce
 API version:  1.37
 Go version:   go1.9.2
 Git commit:   9ee9f40
 Built:        Thu Apr 26 07:12:25 2018
 OS/Arch:      linux/amd64
 Experimental: false
 Orchestrator: swarm

Server:
 Engine:
  Version:      18.03.1-ce
  API version:  1.37 (minimum version 1.12)
  Go version:   go1.9.5
  Git commit:   9ee9f40
  Built:        Thu Apr 26 07:22:38 2018
  OS/Arch:      linux/amd64
  Experimental: true
```

_NOTE: Output will differ based on the container and server versions being used._

## Building

To build the image with a different Docker client version:

```bash
docker build --build-arg DOCKER_CLI_VERSION="17.06.0" -t my-docker-client .
```

Running the container will output the Docker client version:

```bash
docker run my-docker-client
```

```text
Docker version 17.06.0-ce, build 02c1d87
```

## Changes

When you make a change, please update the `CHANGELOG.md` file.

## Releasing a New Version

Only contributors can release new versions.

In order to release a new version, you must have Docker running locally. It is
easiest if you are using a tool like Docker Machine, but as long as you are able
to run the `docker` commands, everything is good.

Releasing a new version involves two steps: building and pushing. To build the
new image, you issue a build command with the appropriate tag. The tag follows
the format `timberio/docker-client:$(version)`.

The `$(version)` should be the version of the Docker client.

To build the new image, use the following command from the directory:

```bash
docker build -t TAG .
```

replacing TAG with the appropriate tag. Once the image has successfully built,
you can push the image to the repository using the following command:

```bash
docker push TAG
```

replacing TAG with the appropriate tag. Note that in order to do this you must
be logged in and have write permissions on the timberio/docker-client image in
DockerHub.

_NOTE: All stable versions of the Docker client can be built and released by running
the `release.sh` script._
