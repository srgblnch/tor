#!/bin/bash

source scripts/options.sh

# FIXME: improve tag field for $DISTRIBUTION/$IMAGE:$RELEASE support
#        issue saw when build two images only changing the release.

ln -s $IMAGE/Dockerfile Dockerfile

docker build \
	--build-arg DISTRO=$DISTRIBUTION \
	--build-arg RELEASE=$RELEASE \
	-t $DISTRIBUTION/$RELEASE/$IMAGE:$version \
	.

rm Dockerfile
