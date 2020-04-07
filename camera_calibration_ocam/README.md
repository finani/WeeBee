# How to Calibrate OCam (camera)
1. recommand to use 'WeeBee/Camera_Calibration_Ocam/usb_cam'
- It is modified from http://wiki.ros.org/usb_cam
2. sudo apt-get install ros-melodic-image-pipeline
3. sudo apt-get install ros-melodic-camera-calibration
4. rosrun camera_calibration cameracalibrator.py --size 9x6 --square 0.67 image:=/camera/image_raw camera:=/camera --no-service-check
- It is from http://wiki.ros.org/camera_calibration
5. edit usb_cam/param/usb_cam.yaml
- Change the camera_matrix, distortion_coefficients, rectification_matrix and projection_matrix
