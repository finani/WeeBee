# How to Set up QSF Pro (Qualcomm Snapdragon Flight Pro)
> https://support.intrinsyc.com/projects/qualcomm-flight-pro-development-kit/wiki

## Flash BSP(Board Support Package) on the QSF Pro
> Connect QSF Pro using micro usb 2.0 type b (data cable for Android)
> It will reset the QSF Pro
1. Download JFlash File from Google Drive
```
mkdir ~/qsf_pro && cd ~/qsf_pro
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1SHqVo3W6zNKas3e4Rmd6cXlMqIbWd0Nh' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1SHqVo3W6zNKas3e4Rmd6cXlMqIbWd0Nh" -O 'QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2.zip' && rm -rf /tmp/cookies.txt
```
2. Unzip & Flash
```
unzip QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2.zip
cd QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2
chmod +x jflash.sh
./jflash.sh
```

## Install Machine Vision & Navigator SDK
1. Download Machine Vision SDK from Google Drive
```
cd ~/qsf_pro
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1MTOlafF6N1Yv3CKvzXxbzaD72gCfhhsG' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1MTOlafF6N1Yv3CKvzXxbzaD72gCfhhsG" -O 'mv_1.1.9_8x96.ipk' && rm -rf /tmp/cookies.txt
```
2. Copy and Install Machine Vision SDK using adb
```
sudo apt install adb
adb shell mkdir -p /data/bin
adb push mv_1.1.9_8x96.ipk /data/bin
adb shell opkg install /data/bin/mv_1.1.9_8x96.ipk
```
3. How to get license file
> Open the link below -> Create an acount -> Log in -> Download Navigator SDK File (Same as 5. Navigator SDK) -> Wait 1-2 business days for email with lisence file

> https://developer.qualcomm.com/software/qualcomm-navigator/tools
4. Import license file to the QSF Pro
```
adb shell mkdir -p /opt/qcom-licenses
adb push snapdragon-flight-license.bin /opt/qcom-licenses/
```
5. Download Navigator SDK from Google Drive
```
cd ~/qsf_pro
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=10dmV6-uhf4TLD3qancQXwVm2z8zTPr1e' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=10dmV6-uhf4TLD3qancQXwVm2z8zTPr1e" -O 'snav_1.2.59_8x96.ipk' && rm -rf /tmp/cookies.txt
```
6. Copy and Install Navigator SDK using adb
```
adb shell mkdir -p /data/bin
adb push snav_1.2.59_8x96.ipk /data/bin
adb shell opkg install /data/bin/snav_1.2.59_8x96.ipk
adb shell /etc/snav/enable_snav.sh
```
7. Create symbolic link & Start Navigator
```
adb shell ln -s /usr/lib/rfsa/adsp/200qc_runtime_params.xml /usr/lib/rfsa/adsp/snav_params.xml
adb shell start snav
```
8. Sensor Calibration
> It is for sensor calibration. The QSF Pro should be on a level surface during this calibration.
```
adb shell snav_calibration_manager -s
```

## Install Docker Image for Development on the Host Computer
1. Install Docker Engine on Ubuntu
> https://docs.docker.com/engine/install/ubuntu/
2. Download Docker File from Google Drive
```
cd ~/qsf_pro
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1dfpLzTA9Dl_1Oah6_aqrkHi6Q1y6_n7-' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1dfpLzTA9Dl_1Oah6_aqrkHi6Q1y6_n7-" -O 'QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2_Docker.zip' && rm -rf /tmp/cookies.txt
```
3. Unzip & Import Flight Pro Docker Image into Docker
```
unzip QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2_Docker.zip
cd docker && docker load < excelsior-arm-sdk-sfpro_docker.tar
docker images
```
4. Run Docker and exit
```
mkdir -p ~/docker/flight_pro
cp ~/qsf_pro/docker/run_docker.sh ~/docker/flight_pro
export SPRINT="null" 
sudo apt-get install qemu-user-static
cd ~/docker/flight_pro && sudo chmod a+x run_docker.sh
./run_docker.sh atlflight/excelsior-arm-sdk-sfpro_docker
exit
```
### Docker Usage Example
1. Copy Examples and Run Docker
> On the host computer
```
cp ~/qsf_pro/docker/examples ~/docker/flight_pro/sdk_home/examples
cd ~/docker/flight_pro && ./run_docker.sh atlflight/excelsior-arm-sdk-sfpro_docker
```
2. Build and Run Hello_World on ther Docker
> Within the docker shell
```
cd ~/examples/cross_compile/cmake
mkdir build && cd build
cmake ..
make
./hello
exit
```
3. Copy and Run Hello_World on the QSF Pro
> On the host computer
```
cd ~/docker/flight_pro/sdk_home/examples/cross_compile/cmake/build
adb shell mkdir -p /data/bin/
adb push hello /data/bin/
adb shell ./data/bin/hello
```

## How to Setup ROS on the QSF Pro
> Run Camera Streaming Example
1. Run Docker
> On the host computer
```
cd ~/docker/flight_pro && ./run_docker.sh atlflight/excelsior-arm-sdk-sfpro_docker
```
2. Create a new workspace for ROS and Run roscore
> Within the docker shell
```
mkdir -p ~/ros/src && cd ~/ros/src
source /opt/ros/indigo/setup.bash
catkin_init_workspace
cd .. && catkin_make
source ~/ros/devel/setup.bash
roscore
[ctrl]+c
```
3. Download snap_cam_ros and snap_msgs git files
> Within the docker shell
```
cd ~/ros/src
git clone https://github.com/finani/snap_cam_ros.git
git clone https://github.com/ATLFlight/snap_msgs.git
```
4. Set git submodule
> On the host computer
```
cd ~/docker/flight_pro/sdk_home/ros/src/snap_cam_ros
git submodule init
git submodule update
```
5. Build and Zip the ROS Workspace
> Within the docker shell
```
cd ~/ros && catkin_make -DCMAKE_BUILD_TYPE=Release -DQC_SOC_TARGET=APQ8096 install
cd ~/ && tar -cvzf ros.tgz ~/ros
```
6. Copy and Unzip the ROS Workspace on the QSF Pro
> On the host computer
```
adb shell mkdir -p ~/
cd ~/docker/flight_pro/sdk_home && adb push ros.tgz ~/
adb shell tar -xvzf ~/ros.tgz
```
7. Set ROS Environment and Stream Camera Image on the QSF Pro
> Within the QSF Pro
```
adb shell
export ROS_ROOT=/opt/ros; export ROS_DISTRO=indigo; export ROS_PACKAGE_PATH=/opt/ros/indigo/share; export PATH=$PATH:/opt/ros/indigo/bin; export LD_LIBRARY_PATH=/opt/ros/indigo/lib; export PYTHONPATH=/opt/ros/indigo/lib/python2.7/site-packages; export ROS_MASTER_URI=http://localhost:11311; export CMAKE_PREFIX_PATH=/opt/ros/indigo; touch /opt/ros/indigo/.catkin; export ROS_IP=192.168.1.1
source /home/weebee-test/ros/devel/setup.sh
cd ../src/snap_cam_ros/
roslaunch snap_cam_ros hires.launch
```
8. Set ROS Environment and Subscribe Camera Image
> On the host computer
> SSID: QSoftAP, Password: 1234567890, QSF_Pro_IP: 192.168.1.1, Host_Computer_IP: 192.168.1.52
```
source /opt/ros/melodic/setup.bash
export ROS_IP=192.168.1.52
export ROS_MASTER_URI=http://192.168.1.1:11311
rosrun rqt_image_view rqt_image_view
```

## How to Setup ROS VIO Packages on the QSF Pro
1. Run Docker
> On the host computer
```
cd ~/docker/flight_pro && ./run_docker.sh atlflight/excelsior-arm-sdk-sfpro_docker
```
2. Copy and Insatll SDK Files
> On the host computer
```
cp ~/qsf_pro/mv_1.1.9_8x96.ipk ~/docker/flight_pro/sdk_home/
```
> Within the docker shell
```
cd ~/ && opkg install mv_1.1.9_8x96.ipk
```
3. catkin_make and source bash files
> Within the docker shell
```
source /opt/ros/indigo/setup.bash
cd ~/ros && catkin_make -DCMAKE_BUILD_TYPE=Release -DQC_SOC_TARGET=APQ8096 install
source devel/setup.bash
```
4. Download ROS Packages from github
> Within the docker shell
```
git clone https://github.com/ATLFlight/snap_imu.git
git clone https://github.com/ATLFlight/qflight_descriptions.git
git clone https://github.com/finani/snap_cpa.git
git clone https://github.com/finani/snap_vio.git
```
5. catkin_make and copy
> Within the docker shell
```
cd ~/ros && catkin_make -DCMAKE_BUILD_TYPE=Release -DQC_SOC_TARGET=APQ8096 install
cd ~/ && tar -cvzf ros.tgz ~/ros
```
6. Copy and Unzip the ROS Workspace on the QSF Pro
> On the host computer
```
adb shell rm -r ~/ros ~/ros.tgz
cd ~/docker/flight_pro/sdk_home && adb push ros.tgz ~/
adb shell tar -xvzf ~/ros.tgz
```
7. Set ROS Environment and Roslaunch vio package on the QSF Pro
> Within the QSF Pro
```
adb shell
export ROS_ROOT=/opt/ros; export ROS_DISTRO=indigo; export ROS_PACKAGE_PATH=/opt/ros/indigo/share; export PATH=$PATH:/opt/ros/indigo/bin; export LD_LIBRARY_PATH=/opt/ros/indigo/lib; export PYTHONPATH=/opt/ros/indigo/lib/python2.7/site-packages; export ROS_MASTER_URI=http://localhost:11311; export CMAKE_PREFIX_PATH=/opt/ros/indigo; touch /opt/ros/indigo/.catkin; export ROS_IP=192.168.1.1
source /home/weebee-test/ros/devel/setup.sh
cd /home/weebee-test/ros/src/snap_vio/
imu_app -s 2 -p 10 &
roslaunch snap_vio standalone.launch
```
8. Set ROS Environment and Subscribe VIO data
> On the host computer
> SSID: QSoftAP, Password: 1234567890, QSF_Pro_IP: 192.168.1.1, Host_Computer_IP: 192.168.1.52
```
source /opt/ros/melodic/setup.bash
export ROS_IP=192.168.1.52
export ROS_MASTER_URI=http://192.168.1.1:11311
rostopic echo /downward/vio/pose -c
```

# Trobleshooting
1. run_docker.sh does not work
> Error Messages
```
Usage: run_docker.sh \<docker-image-path-or-url\>
Example: run_docker.sh docker-registry.com/excelsior-dockers/excelsior-arm-sdk-eco
```
> If run_docker.sh is not working, open 'run_docker.sh' and comment the code below
```
# if [ -z ${SPRINT} ]; then
#     echo "Usage: `basename $0` <docker-image-path-or-url>"
#     echo "Example: `basename $0` docker-registry.com/excelsior-dockers/excelsior-arm-sdk-eco"
#     exit 1
# fi
```
