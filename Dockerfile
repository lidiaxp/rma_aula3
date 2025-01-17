FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=noetic

RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    lsb-release \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-get update \
    && apt-get install -y ros-noetic-desktop-full

RUN apt-get install -y \
    python3-catkin-tools \
    ros-noetic-velodyne-description \
    ros-noetic-velodyne-gazebo-plugins \
    ros-noetic-amcl \
    ros-noetic-costmap-converter \
    ros-noetic-depthimage-to-laserscan \
    ros-noetic-dynamic-reconfigure \
    ros-noetic-ddynamic-reconfigure \
    ros-noetic-geometry2 \
    ros-noetic-hector-slam \
    ros-noetic-move-base \
    ros-noetic-move-base-flex \
    ros-noetic-navigation \
    ros-noetic-openslam-gmapping \
    ros-noetic-rplidar-ros \
    ros-noetic-slam-gmapping \
    ros-noetic-spatio-temporal-voxel-layer \
    ros-noetic-teb-local-planner \
    ros-noetic-teleop-twist-keyboard \
    ros-noetic-teleop-twist-joy \
    ros-noetic-urg-node \
    ros-noetic-rtabmap \
    ros-noetic-rtabmap-ros \
    ros-noetic-octomap \
    ros-noetic-octomap-ros \
    ros-noetic-octomap-rviz-plugins \
    ros-noetic-octomap-server \
    ros-noetic-imu-filter-madgwick \
    ros-noetic-robot-localization \
    ros-noetic-robot-pose-ekf \
    ros-noetic-pointcloud-to-laserscan \
    ros-noetic-rosbridge-server \
    ros-noetic-map-server \
    ros-noetic-realsense2-camera \
    ros-noetic-realsense2-description \
    ros-noetic-cmake-modules \
    ros-noetic-velodyne-gazebo-plugins \
    ros-noetic-ompl \
    ros-noetic-navfn \
    ros-noetic-dwa-local-planner \
    ros-noetic-global-planner \
    ros-noetic-costmap-2d \
    ros-noetic-robot-self-filter \
    ros-noetic-ros-numpy \
    ros-noetic-pcl-ros \
    ros-noetic-pcl-conversions \
    ros-noetic-grid-map-costmap-2d \
    ros-noetic-grid-map-ros \
    ros-noetic-grid-map-filters \
    ros-noetic-grid-map-visualization \
    ros-noetic-tf2-tools \
    ros-noetic-hector-gazebo-plugins \
    pcl-tools \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    gedit \
    ssh \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libx11-dev \
    libavformat-dev \
    libavdevice-dev \
    libavcodec-dev \
    libavutil-dev \
    libswresample-dev \
    libglu-dev \
    libdc1394-22-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    mesa-common-dev \
    python3-pip \
    git \
    tmux \
    && python3 -m pip install --upgrade pip \
    && pip3 install numpy scipy scikit-learn scikit-image \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/catkin_ws/src \
    && cd /home/catkin_ws/ \
    && /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && catkin_make -DCMAKE_BUILD_TYPE=Release" \
    && echo "source /home/$USER/catkin_ws/devel/setup.bash" >> ~/.bashrc

RUN mkdir -p /home/catkin_ws/src && \
    cd /home/catkin_ws/src && \
    git clone https://github.com/rrdpereira/SuperMegaBot_SMB.git && \
    cd /home/catkin_ws && \
    /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && catkin_make"


RUN echo "source /home/$USER/catkin_ws/devel/setup.bash" >> /etc/bash.bashrc

WORKDIR /home/catkin_ws

CMD ["bash"]
