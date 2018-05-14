#!/usr/bin/env bash

# Read versions from docker and write to local file
versions=$(curl -s https://download.docker.com/linux/static/stable/x86_64/ \
	| grep docker \
	| sed -n 's/.*href="docker-\(.*\).tgz".*/\1/p'
)
printf "%s\\n" "${versions[@]}" > VERSIONS.txt


# Loop over versions and tag most recent version with latest
count=0
latest=$(wc -l < VERSIONS.txt | awk '{$1=$1};1')

while IFS= read -r version; do
	(( count++ ))

	docker build --build-arg DOCKER_CLI_VERSION="$version" -t "timberio/docker-client:$version" .
	docker push "timberio/docker-client:$version"

	if [[ "$count" == "$latest" ]]; then
		docker tag "timberio/docker-client:$version" timberio/docker-client:latest
		docker push timberio/docker-client:latest
	fi
done < <(cat VERSIONS.txt)
