# ROS Melodic Install
1. sudo apt-get install chrony ntpdate
2. sudo ntpdate ntp.ubuntu.com
#
3. sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
4. sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
#
5. sudo apt-get update
6. sudo apt-get upgrade
#
7. sudo apt install ros-melodic-desktop-full
8. sudo apt-get install ros-melodic-rqt-*
#
9. sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools python-rosdep
#
10. sudo rosdep init
11. rosdep update
12. source /opt/ros/melodic/setup.bash
#
13. mkdir -p ~/catkin_ws/src
14. cd ~/catkin_ws/src
15. catkin_init_workspace
16. cd ~/catkin_ws/
17. catkin build
18. source ~/catkin_ws/devel/setup.bash
#
19. gedit ~/.bashrc
```
# Set ROS Melodic
source /opt/ros/melodic/setup.bash
source ~/catkin_ws/devel/setup.bash

# Set ROS Network
# export ROS_MASTER_URI=http://localhost:11311
# export ROS_HOSTNAME=localhost

# set ROS Alias Command
alias cw='cd ~/catkin_ws'
alias cs='cd ~/catkin_ws/src'
alias cm='cd ~/catkin_ws && catkin_make'
alias cb='cd ~/catkin_ws && catkin build'

# Set User Alias
alias rm='rm -rf'
alias eb='gedit ~/.bashrc' 
alias sb='source ~/.bashrc'
alias agi='sudo apt-get install'  
alias gs='git status'  
alias gp='git pull'
```


