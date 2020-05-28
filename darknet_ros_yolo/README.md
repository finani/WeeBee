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
# How to turn off downloading the weight files
11. gedit ~/catkin_ws/src/darknet_ros/darknet_ros/CMakeLists.txt
12. [Comment] Download weight lines
- #execute_process(COMMAND wget http://pjreddie.com/media/files/yolov2-tiny.weights -P ${PATH})
- #execute_process(COMMAND wget http://pjreddie.com/media/files/yolov3.weights -P ${PATH})
- #execute_process(COMMAND wget http://pjreddie.com/media/files/yolov2.weights -P ${PATH})
# Install CUDA (v10.0), cuDNN (v7.6)
> from https://github.com/localryu/TIL/blob/master/Object_detection/tensorflow_object_detection.md
13. cd ~/Downloads && wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux
- https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux
14. sudo sh cuda_10.0.130_410.48_linux
- 'accept', 'n', 'y', '', 'y', 'y', ''
- Fallow the command-line prompts except install nvidia-driver (make sure press 'n')
15. gedit ~/.bashrc
- export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
- export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
16. cd ~/Downloads && wget https://developer.download.nvidia.com/compute/machine-learning/cudnn/secure/v7.5.1/prod/10.0_20190418/cudnn-10.0-linux-x64-v7.5.1.10.tgz?QntrMMEJDmrh6PFPMtRbTcytS5axIAbdOMjsTAY6eNpXhf7JnnJlCqC3mJQ9GlHwQVzfQqiWIO-snDE_2EPCdfRi7Y_szzMa1LA7KxWcCmaCHr0thRypwysGMqoHzgkSlJ6W54i2zlEfqvRo0mAAZiSdQTO0yPsVm8c_R5Sfwzto3w6zzR3Tix1fSQSFEz1TPuG544nmYsXO1rc-j41rXCM
- https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.5.1/prod/10.0_20190418/cudnn-10.0-linux-x64-v7.5.1.10.tgz
17. sudo tar -xzvf cudnn-10.0-linux-x64-v7.5.1.10.tgz* 
18. cd cuda && sudo cp include/cudnn.h /usr/local/cuda/include
19. sudo cp lib64/libcudnn* /usr/local/cuda/lib64
20. sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
21. cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2

# Turn on GPU, CUDNN, OPENCV & Build
22. gedit ~/catkin_ws/src/darknet_ros/darknet/Makefile
- GPU = 1
- CUDNN = 1
- OPENCV = 1
23. catkin build darknet_ros -DCMAKE_BUILD_TYPE=Release
- from https://github.com/leggedrobotics/darknet_ros
