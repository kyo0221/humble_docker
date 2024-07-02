#!/bin/bash

eval "docker container run --network host -it --name ros2-env -e DISPLAY=$DISPLAY --volume="/tmp/.x11-unix:/tmp/.x11-unix:rw" -v $PWD/share:/home --privileged --env="XAUTHORITY=$XAUTH" -v "$XAUTH:$XAUTH" --env="QT_X11_NO_MITSHM=1" --ipc=host kyo0221/humble:ros2-env"