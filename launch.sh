#!/bin/bash

source scripts/options.sh

# FIXME: check the image is available in the docker images
# FIXME: check the arguments after the firsts that are valid to be passed to run
# FIXME: how can be preset that an image is thought to be -i or -d

docker run -i --name $1 \
	--rm \  # --restart unless-stopped \
	--net host \  # ${@:3} \
	debian/$1:$RELEASE

