# x11-docker
A Docker image for running X11 applications from within a container.
Please note that this is still very much a work in progress, and may be prone to glitches and other unexpected behaviour.

# Building the image
```
git clone https://github.com/richarah/x11-docker.git
cd x11-docker
docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) -t x11-docker .
```

# First-time setup
In order to run X11 apps from within a container, it is necessary to create an `xauth` file and set the appropriate access permissions:
```
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -
```

# Run
With the above steps completed, the container may be run as follows - by default, this runs an `xeyes` demo, though this may be changed with the `--entrypoint` argument.
```
docker run -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw -e XAUTHORITY=/tmp/.docker.xauth x11-docker
```
