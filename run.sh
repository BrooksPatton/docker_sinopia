#!/bin/bash

SINOPIA_EXTERNAL_PORT=4873
TAG_VERSION="latest"
CONTAINER_NAME="sinopia"

function verify_docker_is_running() {
  DOCKER_INFO_OUTPUT=$(docker info 2> /dev/null | grep "Containers:" | awk '{print $1}')

  if [ "$DOCKER_INFO_OUTPUT" == "Containers:" ]
    then
      print_to_screen "Docker is running"
    else
      print_to_screen "Docker is not running, exiting"
      exit 1
  fi
}

function run_sinopia_container() {
  docker run --name "$CONTAINER_NAME" -d -p "$SINOPIA_EXTERNAL_PORT":4873 brookzerker/sinopia:"$TAG_VERSION" || error "There was a problem starting the container"
}

function error() {
  echo
  echo "================================="
  echo "$1"
  echo "================================="
  echo
  exit 1
}

verify_docker_is_running
run_sinopia_container
