#!/bin/bash

#
# Clean up docker containers and images as they can get out of hand, pretty quickly.
#

# Decision time
if_yes() {
  echo -n "Delete $1? [y/n]: "
  read ans
  [[ "$ans" = "y" ]] && return 0 || return 1
}

# Quick announcement
echo "This script will clean up ALL Docker containers AND/OR images."

# container stuff
containers_cmd="docker rm"
containers=$(docker ps -a -q)

# image stuff
images_cmd="docker rmi"
images=$(docker images -q)

# This is the workhorse
if_yes containers && ( [[ -n "${containers}" ]] && ${containers_cmd} ${containers} || echo "Nothing to do here." )
if_yes images && ( [[ -n "${images}" ]] && ${images_cmd} ${images} || echo "Nothing to do here." )
