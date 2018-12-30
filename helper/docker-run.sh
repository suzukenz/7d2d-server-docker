#!/bin/bash
IMAGE_NAME=suzukenz/7d2d

# Absolute path is recommended
HOST_DIR=/Users/kentony/7d2d/

docker run \
  -p 26900:26900/tcp \
  -p 26900-26903:26900-26903/udp \
  -v $HOST_DIR:/7d2d \
  -it --rm $IMAGE_NAME ${@+"$@"}
