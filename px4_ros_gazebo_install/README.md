> do not use 'ubuntu_sim_ros_kinetic_edited.sh'
> 
> PX4-Autopilot does not support Ubuntu 16.04

# Change Mavros Installation from source to binary
1. source ubuntu_sim_ros_melodic_edited.sh

## Change Simulation Speed
The simulation speed can be increased or decreased with respect to realtime using the environment variable PX4_SIM_SPEED_FACTOR.
```
export PX4_SIM_SPEED_FACTOR=2
make px4_sitl_default gazebo
```
---
# Docker for px4_ros_gazebo
> https://github.com/finani/WeeBee/tree/master/tensorflow_docker_install
1. sudo docker pull px4io/px4-dev-ros-melodic

