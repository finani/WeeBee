# Install nvidia graphic driver 
1. sudo apt-get install --no-install-recommends nvidia-driver-418
 - Reboot
2. nvidia-smi
 - Check that GPUs are visible

# Install the Docker on Ubuntu
- Set up the repository
3. sudo apt-get remove docker docker-engine docker.io containerd runc
- Delete old version of the docker
4. sudo apt-get update
5. sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
6. curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
7. sudo apt-key fingerprint 0EBFCD88
 - Check the fingerprint is 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
8. sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   
#
- Install Docker engine
9. sudo apt-get update
10. sudo apt-get install docker-ce docker-ce-cli containerd.io
- or go to 10a-10b. (for specific version)
10a. apt-cache madison docker-ce
 - Check the version of the Docker (<VERSION_STRING> = 5:19.03.8~3-0~ubuntu-bionic)
10b. sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
 - sudo apt-get install docker-ce=5:19.03.8~3-0~ubuntu-bionic docker-ce-cli=5:19.03.8~3-0~ubuntu-bionic containerd.io

# Install NVIDIA Docker Support
11. distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
12. curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
13. curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
14. sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
15. sudo systemctl restart docker
16. docker run --gpus all nvidia/cuda:10.0-base nvidia-smi
 - Test nvidia-smi with the latest official CUDA image

# Install the tensorflow container
17. 
