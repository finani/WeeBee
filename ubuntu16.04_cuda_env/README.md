# Install CUDA (v9.2), cuDNN (v7.6.5), TensorRT (v4.0.1.6), OpenCV (v4.5.0)
- intel i7-10700F
- 32GiB RAM
- Geforce RTX2060

## Install Nvidia driver 460 for RTX2060
1. Clean relative packages
```
sudo apt remove --purge -y nvidia* cublas* cuda* cudnn* tensorrt* \
  && sudo apt autoremove -y \
  && sudo apt update -y \
  && sudo apt upgrade -y
```
2. Install nvidia driver using run file
- https://www.nvidia.co.kr/Download/index.aspx?lang=kr
3. Or using cuda 10.2 package
    1. Install cuda 10.2
    ```
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_10.2.89-1_amd64.deb \
      && sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
      && sudo apt update \
      && sudo dpkg -i cuda-repo-ubuntu1604_10.2.89-1_amd64.deb \
      && sudo apt update \
      && sudo apt install -y cuda-10.2
    ```
    2. Remove cuda 10.2
    ```
    sudo apt remove --purge -y cuda-10.2* \
      && sudo apt autoremove -y
    ```
    3. Install nvidia driver (v460)
    ```
    sudo apt install -y nvidia-460
    ```
    4. Reboot
    ```
    sudo reboot now
    ```
4. check nvidia driver version (installed completely)
```
nvidia-smi
cat /proc/driver/nvidia/version
```

## Install Cuda 9.2
1. using cuda 9.2 run file
```
wget -O cuda_9.2.148_396.37_linux.run https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_9.2.148_396.37_linux \
  && sudo chmod +x cuda_9.2.148_396.37_linux.run \
  && sudo ./cuda_9.2.148_396.37_linux.run
```
2. Install cuda 9.2 patch
```
wget -O cuda_9.2.148.1_linux.run https://developer.nvidia.com/compute/cuda/9.2/Prod2/patches/1/cuda_9.2.148.1_linux \
  && sudo chmod +x cuda_9.2.148.1_linux.run \
  && sudo ./cuda_9.2.148.1_linux.run
```
3. Set cuda environment variables
```
cuda_source="
# Set cuda path
export PATH=/usr/local/cuda-9.2/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" \
  && echo "$cuda_source" >> ~/.bashrc
```
4. Reboot
```
sudo reboot now
```

## Install CuDNN 7.6.5
1. Install CuDNN 7.6.5
```
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb \
  && sudo dpkg -i nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb \
  && sudo apt update \
  && sudo apt install -y libcudnn7=7.6.5.32-1+cuda9.2 libcudnn7-dev=7.6.5.32-1+cuda9.2 --allow-change-held-packages
```

## Install TensorRT 4.0.1.6
1. Download TensorRT repo
- https://developer.nvidia.com/nvidia-tensorrt-download
2. Add TesorRT repo
```
sudo dpkg -i nv-tensorrt-repo-ubuntu1604-cuda9.2-ga-trt4.0.1.6-20180612_1-1_amd64.deb \
  && sudo apt update
```
3. Install TensorRT 4.0.1.6
```
sudo apt install -y python-libnvinfer=4.1.2-1+cuda9.2 \
    python-libnvinfer-dev=4.1.2-1+cuda9.2 \
    python3-libnvinfer=4.1.2-1+cuda9.2 \
    python3-libnvinfer-dev=4.1.2-1+cuda9.2 \
    libnvinfer4=4.1.2-1+cuda9.2 \
    libnvinfer-dev=4.1.2-1+cuda9.2 \
    libnvinfer-samples=4.1.2-1+cuda9.2 \
    graphsurgeon-tf=4.1.2-1+cuda9.2 \
    uff-converter-tf=4.1.2-1+cuda9.2 --allow-change-held-packages \
  && sudo apt install -y tensorrt=4.0.1.6-1+cuda9.2 --allow-change-held-packages
```
4. Reboot
```
sudo reboot now
```
5. check Cuda install completely
```
nvcc --version
```
6. check CuDNN installed completely
```
cat /usr/include/cudnn.h | grep CUDNN_MAJOR -A 2
```
7. check TensorRT installed completely
```
dpkg -l | grep TensorRT
```

## Install OpenCV 4.5.0
1. Install OpenCV 4.5.0
```
sudo apt install -y cmake \
  && sudo apt install -y libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev \
  && sudo apt install -y libqt4-dev \
  && sudo apt install -y libatlas-base-dev gfortran libeigen3-dev \
  && sudo apt install -y python2.7-dev python3-dev python-numpy python3-numpy \
  && wget -O opencv.zip https://github.com/opencv/opencv/archive/4.5.0.zip \
  && unzip opencv.zip \
  && wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.5.0.zip \
  && unzip opencv_contrib.zip \
  && cd opencv-4.5.0 \
  && mkdir build \
  && cd build \
  && cmake -D CMAKE_BUILD_TYPE=Release \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.5.0/modules \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_TBB=ON \
    -D WITH_QT=ON \
    -D WITH_PTHREADS_PF=ON \
    -D WITH_OPENNI2=OFF \
    -D WITH_OPENNI=OFF \
    -D WITH_OPENGL=ON \
    -D WITH_IPP=ON \
    -D WITH_CSTRIPES=ON \
    -D WITH_CUBLAS=ON \
    -D WITH_V4L=ON \
    -D WITH_CUDA=ON \
    -D WITH_GDAL=ON \
    -D WITH_XINE=ON \
    -D WITH_NVCUVID=OFF \
    -D WITH_CUFFT=ON \
    -D WITH_EIGEN=ON \
    -D WITH_LAPACK=ON \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D BUILD_EXAMPLES=ON \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_opencv_legacy=ON \
    -D BUILD_TIFF=ON \
    -D BUILD_opencv_java=ON \
    -D USE_GStreamer=ON \
    -D FORCE_VTK=ON \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D ENABLE_FAST_MATH=1 \
    -D CUDA_FAST_MATH=1 \
    -D CUDA_GENERATION=Auto \
    -D CUDA_ARCH_BIN=7.5 \
    -D CUDA_NVCC_FLAGS="-D_FORCE_INLINES" \
    -D CMAKE_C_COMPILER=$(which gcc) \
    -D CMAKE_CXX_COMPILER=$(which g++) \
    -D PYTHON_INCLUDE_DIR=/usr/include/python2.7 \
    -D PYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python2.7 \
    -D PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so \
    -D BUILD_opencv_freetype=OFF .. \
  && make -j15 \
  && sudo make install -j15 \
  && cd
```
