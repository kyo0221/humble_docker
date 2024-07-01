FROM ubuntu:22.04

WORKDIR /ros2_ws/src

COPY config/.bashrc /.bashrc
COPY config/.vimrc /.vimrc
COPY config/.tmux.conf /.tmux.config

ENV DEVIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

# Install tzdata with environment variables to bypass interactive prompt
RUN apt update && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt install -y tzdata

RUN apt update && \
    apt install -y \
    wget \
    bzip2 \
    build-essential \
    git \
    git-lfs \
    vim \
    curl \
    ca-certificates \
    libsndfile1-dev \
    libgl1 \
    python3-pip \
    tmux \
    tree \
    gnupg2 \
    lsb-release

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

RUN apt update && \
    apt install -y ros-humble-desktop

RUN apt install -y python3-colcon-common-extensions