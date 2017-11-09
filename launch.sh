#!/bin/bash

source scripts/options.sh
source $1/launchparams.sh

# FIXME: check the image is available in the docker images
# FIXME: check the arguments after the firsts that are valid to be passed to run
# FIXME: how can be preset that an image is thought to be -i or -d

docker run -i --name $1 \
	$PERSISTENCY \
	$NETWORKING \
	debian/$1:$RELEASE
