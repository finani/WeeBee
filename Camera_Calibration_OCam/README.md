# How to Calibrate Ocam (camera)
1. sudo apt-get install ros-melodic-usb-cam
2. sudo apt-get install ros-melodic-image-pipeline
3. sudo apt-get install ros-melodic-camera-calibration
4. rosrun camera_calibration cameracalibrator.py --size 9x6 --square 0.67 image:=/my_camera/image camera:=/my_camera
- from http://wiki.ros.org/camera_calibration
