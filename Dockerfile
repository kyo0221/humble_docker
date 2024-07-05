FROM ubuntu:22.04

ENV DEVIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

ARG ROS_DISTRO=humble
ARG ROS_PKG=desktop

ENV ROS_ROOT=/opt/ros/${ROS_DISTRO}
ENV ROS_PYTHON_VERSION=3

# Install tzdata with environment variables to bypass interactive prompt
RUN apt update && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt install -y tzdata

# install basic packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        x11-apps \
        mesa-utils \
        curl \
        lsb-release \
        less \
        tmux \
        command-not-found \
        git \
        xsel \
        vim \
        plocate \
        tree \
        wget \
        gnupg \
        build-essential \
        python3-dev \
        python3-pip \
        && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
        ros-humble-desktop \
        && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* 

# install ros2 packages
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
        ros-${ROS_DISTRO}-${ROS_PKG} \
        ros-${ROS_DISTRO}-gazebo-ros-pkgs \
        ros-${ROS_DISTRO}-joint-state-publisher* \
        python3-colcon-common-extensions \
        ros-${ROS_DISTRO}-can-msgs \ 
        python3-colcon-mixin \
        python3-rosdep \
        python3-vcstool && \
    sudo rosdep init && \
    rosdep update --rosdistro ${ROS_DISTRO} && \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

WORKDIR /home
ENV HOME /home 

COPY config/.bashrc /home/.bashrc
COPY config/.vimrc /home/.vimrc
COPY config/.tmux.conf /home/.tmux.conf
COPY test/.test.sh /home/.test

CMD ["bash"]