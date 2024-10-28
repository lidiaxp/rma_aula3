xhost +
docker run -it --rm \
    -e ROS_MASTER_URI=http://$(ip route | awk '/^default via/ {print $5}' | xargs -I {} ip addr show {} | awk '/inet / {split($2, a, "/"); print a[1]}'):11311 \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e XAUTHORITY=$XAUTH \
    -v $XAUTH:$XAUTH \
    -v $(pwd)/smb_highlevel_controller:/home/catkin_ws/src/smb_highlevel_controller \
    -v $(pwd)/extra_files:/home/catkin_ws/extra_files \
    --net=host \
    --privileged \
    rma_aula3 \
    /bin/bash
