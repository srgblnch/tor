#!/bin/bash

source scripts/options.sh
if [ -d $IMAGE ]; then
	if [ -f $IMAGE/launchparams.sh ]; then
		source $IMAGE/launchparams.sh
	else
		# default: but change for each if not defined
		export INTERACTIVE='-i'
		export PERSISTENCY="--rm"
		export NETWORKING=""
		export VOLUMES=""
	fi
fi

EXIST=`docker inspect --type=image debian/$IMAGE:$RELEASE`
if [ ! $? == 0 ]; then
	echo "Remember to build it first"
	exit
fi

# FIXME: check the image is available in the docker images
# FIXME: check the arguments after the firsts that are valid to be passed to run
# FIXME: how can be preset that an image is thought to be -i or -d

docker run $INTERACTIVE --name $IMAGE \
	$PERSISTENCY $NETWORKING $VOLUMES\
	$DISTRIBUTION/$IMAGE:$RELEASE
