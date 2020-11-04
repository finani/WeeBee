# Install CUDA (v10.0), cuDNN (v7.6), NCCL (v2.0)
1. ./install-cuda-10-bionic.sh
# Make SSH Key
2. ssh-keygen -t rsa -b 4096 -C "10ezenfinani@gmail.com"
> from ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
- [Enter] x3
3. eval "$(ssh-agent -s)"
4. ssh-add ~/.ssh/id_rsa
# Add SSH Key on the Git page
5. sudo apt-get install xclip
6. xclip -sel clip < ~/.ssh/id_rsa.pub
7. [Click] Profile on the Git page
8. [Click] Settings and [Click] SSH and GPG Keys
9. cat ~/.ssh/id_rsa.pub
10. [Copy] SSH Keys to New SSH Keys on the Git page
# Download darknet_ros
11. cd ~/catkin_ws/src && git clone --recursive git@github.com:leggedrobotics/darknet_ros.git
# Turn off downloading the weight files
12. gedit ~/catkin_ws/src/darknet_ros/darknet_ros/CMakeLists.txt
13. [Comment] Download weight lines
```
#execute_process(COMMAND wget http://pjreddie.com/media/files/yolov2-tiny.weights -P ${PATH})
#execute_process(COMMAND wget http://pjreddie.com/media/files/yolov3.weights -P ${PATH})
#execute_process(COMMAND wget http://pjreddie.com/media/files/yolov2.weights -P ${PATH})
```
# Turn on GPU, CUDNN, OPENCV & Build
14. gedit ~/catkin_ws/src/darknet_ros/darknet/Makefile
- GPU = 1
- CUDNN = 1
- OPENCV = 1
15. catkin build darknet_ros -DCMAKE_BUILD_TYPE=Release
- from https://github.com/leggedrobotics/darknet_ros
