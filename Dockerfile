FROM ubuntu:latest AS build-x11
RUN apt-get install apt-transport-https -y && \
    apt-get update && apt-get upgrade -y && \
    apt-get install apt-utils xeyes -y

# Add user with credentials from cmdline
ARG user
ARG uid
ARG gid

ENV USERNAME ${user}
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod  --uid ${uid} $USERNAME && \
        groupmod --gid ${gid} $USERNAME
USER ${user}
WORKDIR /home/${user}

CMD xeyes
