# How to make SSH Key
1. ssh-keygen -t rsa -b 4096 -C "10ezenfinani@gmail.com"
> from ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
- [Enter] x3
2. eval "$(ssh-agent -s)"
3. ssh-add ~/.ssh/id_rsa
# How to add SSH Key on the Git page
4. sudo apt-get install xclip
5. xclip -sel clip < ~/.ssh/id_rsa.pub
6. [Click] Profile on the Git page
7. [Click] Settings and [Click] SSH and GPG Keys
8. cat ~/.ssh/id_rsa.pub
9. [Copy] SSH Keys to New SSH Keys on the Git page
# How to download darknet_ros
10. git clone --recursive git@github.com:leggedrobotics/darknet_ros.git
11. catkin build darknet_ros -DCMAKE_BUILD_TYPE=Release
- from https://github.com/leggedrobotics/darknet_ros
# How to turn off downloading the weight files
12. gedit ~/catkin_ws/darknet_ros/darknet_ros/CMakeLists.txt
13. [Comment] Download weight lines
- #execute_process(COMMAND wget http://pjreddie.com/media/files/yolov2-tiny.weights -P ${PATH})
- #execute_process(COMMAND wget http://pjreddie.com/media/files/yolov3.weights -P ${PATH})
- #execute_process(COMMAND wget http://pjreddie.com/media/files/yolov2.weights -P ${PATH})
