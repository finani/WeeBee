# Change Mavros Installation from source to binary
1. source ubuntu_sim_ros_melodic_edited.sh

# Turn off echo paths
1. sudo gedit ~/catkin_ws/Firmware/Tools/setup_gazebo.bash
2. [Comment echo lines]
```
# echo -e "GAZEBO_PLUGIN_PATH $GAZEBO_PLUGIN_PATH"
# echo -e "GAZEBO_MODEL_PATH $GAZEBO_MODEL_PATH"
# echo -e "LD_LIBRARY_PATH $LD_LIBRARY_PATH"
```

# Docker for px4_ros_gazebo
> https://github.com/finani/WeeBee/tree/master/tensorflow_docker_install
1. sudo docker pull px4io/px4-dev-ros-melodic

# Change Simulation Speed
The simulation speed can be increased or decreased with respect to realtime using the environment variable PX4_SIM_SPEED_FACTOR.
```
export PX4_SIM_SPEED_FACTOR=2
make px4_sitl_default gazebo
```
