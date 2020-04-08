# Install the Docker on Ubuntu
- Set up the repository
1. sudo apt-get remove docker docker-engine docker.io containerd runc
- Delete old version of the docker
2. sudo apt-get update
3. sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
4. curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
5. sudo apt-key fingerprint 0EBFCD88
 - Check the fingerprint is 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
6. sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   
#
- Install Docker engine
7. sudo apt-get update
8. sudo apt-get install docker-ce docker-ce-cli containerd.io
- or go to 8a-8b. (for specific version)
8a.. apt-cache madison docker-ce
 - Check the version of the Docker (<VERSION_STRING> = 5:19.03.8~3-0~ubuntu-bionic)
8b. sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
 - sudo apt-get install docker-ce=5:19.03.8~3-0~ubuntu-bionic docker-ce-cli=5:19.03.8~3-0~ubuntu-bionic containerd.io

# Install NVIDIA Docker Support
9. distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
10. curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
11. curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
12. sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
13. sudo systemctl restart docker
14. docker run --gpus all nvidia/cuda:10.0-base nvidia-smi
 - Test nvidia-smi with the latest official CUDA image

# Install the tensorflow container
9. 
