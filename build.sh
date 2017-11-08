#!/bin/bash

source scripts/options.sh

# FIXME: improve tag field for debian/$1:$RELEASE support
#        issue saw when build two images only changing the release.

ln -s $1/Dockerfile Dockerfile

docker build \
	--build-arg DISTRO=$DISTRIBUTION \
	--build-arg RELEASE=$RELEASE \
	-t debian/$1:$RELEASE \
	.

rm Dockerfile
