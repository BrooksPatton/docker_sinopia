#!/bin/bash
DOCKER_USERNAME="brookzerker"
DOCKER_IMAGE_NAME="sinopia"
DOCKER_TAG="1.0.0"

function verify_docker_is_running() {
  DOCKER_INFO_OUTPUT=$(docker info 2> /dev/null | grep "Containers:" | awk '{print $1}')

  if [ "$DOCKER_INFO_OUTPUT" == "Containers:" ]
    then
      print_to_screen "Docker is running"
    else
      print_to_screen "Docker is not running, exiting"
      exit 3
  fi
}

function verify_dockerfile_exists() {
  if [ -f "Dockerfile" ]
  then
    echo "Found dockerfile, building image..."
  else
    echo "No dockerfile found, exiting"
    exit 1
  fi
}

function build_docker_image() {
  docker build -t "$DOCKER_USERNAME"/"$DOCKER_IMAGE_NAME":"$DOCKER_TAG" . || error "There was a problem building the docker image"
}

function error() {
  echo
  echo "=========================="
  echo "$1"
  echo "=========================="
  echo
  exit 2
}

setup_inputs
verify_docker_is_running
verify_dockerfile_exists
build_docker_image
