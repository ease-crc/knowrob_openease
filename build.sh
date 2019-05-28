#!/bin/sh
# Author: Daniel Beßler
SCRIPT=`readlink -f "$0"`
DIR=`dirname $SCRIPT`
HOST_IP=`ip route list dev docker0 | awk 'NR==1 {print $NF}'`

if [ "$1" = "--local" ]; then
  LOCAL_BUILD=1
else
  LOCAL_BUILD=0
fi

if [ $LOCAL_BUILD -eq 1 ]; then
  if env | grep -q ^ROS_PACKAGE_PATH=; then
    echo "ROS_PACKAGE_PATH is defined."
    WS=`echo $ROS_PACKAGE_PATH | tr ":" "\n" | head -n 1`
    WS1="$(dirname "$WS")"
    echo "Using workspace $WS1"
    if [ $? -eq 0 ]; then
      cd $WS1
      rm -rf $DIR/src.tar
      tar --exclude=.svn --exclude=.git --exclude=build --exclude=bin --exclude=.gradle -cf ./src.tar ./*
      mv ./src.tar "$DIR/"
      cd "$DIR"
    fi
  else
    echo "ERROR: ROS_PACKAGE_PATH is not defined. Please source your ROS workspace for local builds."
    exit 1
  fi
else
  # create empty file because conditional ADD is not possible in Dockerfile.
  # seems docker does not care that it is an empty file.
  touch "$DIR/src.tar"
fi

# $DIR/../../scripts/start-apt-cacher
# $DIR/../../scripts/start-nexus
echo "Building openease/kinetic-knowrob-daemon....";
docker build \
    --build-arg HOST_IP=${HOST_IP} \
    --build-arg LOCAL_BUILD=${LOCAL_BUILD} \
    -t openease/kinetic-knowrob-daemon $DIR
