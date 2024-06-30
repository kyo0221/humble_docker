FROM ubuntu22.04

WORKDIR /home/ros2_ws/src

ENV DEVIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

COPY config/.bashrc /home/.bashrc
COPY config/.vimrc /home/.vimrc
COPY config/.tmux.conf /home/.tmux.config

RUN apt update && \
    apt install -y \
    wget \
    bzip2 \
    build-essential \
    git \
    git-lfs \
    curl \
    ca-certificates \
    libsndfile1-dev \
    libgl1 \
    python3.8 \
    python3-pip \
    tmux \
    gnupg2 \
    lsb-release

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

RUN apt update && \
    apt install -y ros-humble-desktop

RUN apt install -y python3-colcon-common-extensions


