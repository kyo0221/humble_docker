#!/bin/bash
eval "xhost +local:"
eval "docker start ros2-env"


eval "docker container exec -it ros2-env bash"