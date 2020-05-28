# WARNING: These steps seem to not work anymore!

#!/bin/bash

# Install nvidia graphic driver (run seperately)
# sudo apt-get install nvidia-driver-440 nvidia-settings nvidia-modprobe -y
# sudo reboot now

# Check nvidia driver version
# cat /proc/driver/nvidia/version

# Purge existign CUDA first
sudo apt --purge remove "cublas*" "cuda*" -y
sudo apt --purge remove "nvidia*" -y

# Install CUDA Dependencies
sudo apt-get install build-essential dkms -y
sudo apt-get install freeglut3 freeglut3-dev libxi-dev libxmu-dev -y

# Install CUDA Toolkit 10
cd ~/Downloads && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub && sudo apt update
sudo dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb

sudo apt-get autoremove -y
sudo apt-get upgrade -y
sudo apt update
sudo apt install cuda-10.0 -y

# Setup cuda environment variables
cuda_source="
# Set cuda path
export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
echo "$cuda_source" >> ~/.bashrc

# Install CuDNN 7 and NCCL 2
cd ~/Downloads && wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo dpkg -i nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb

sudo apt update
sudo apt install libcudnn7 libcudnn7-dev libnccl2 libc-ares-dev -y

sudo apt autoremove -y
sudo apt upgrade -y

# Link libraries to standard locations
sudo mkdir -p /usr/local/cuda-10.0/nccl/lib
sudo ln -s /usr/lib/x86_64-linux-gnu/libnccl.so.2 /usr/local/cuda/nccl/lib/
sudo ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.7 /usr/local/cuda-10.0/lib64/

echo 'If everything worked fine, reboot now.'

# Check cuda installed completely
# cd /usr/local/cuda-10.0/samples && sudo make
# cd /usr/local/cuda-10.0/samples/bin/x86_64/linux/release
# ./deviceQuery
# ./bandwidthTest

