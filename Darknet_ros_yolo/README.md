# How to make SSH Key
1. ssh-keygen -t rsa -b 4096 -C "10ezenfinani@gmail.com"
from ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
[Enter] x3
2. eval "$(ssh-agent -s)"
3. ssh-add ~/.ssh/id_rsa
# How to add SSH Key on the Git page
1. sudo apt-get install xclip
2. xclip -sel clip < ~/.ssh/id_rsa.pub
3. [Click] Profile on the Git page
4. [Click] Settings and [Click] SSH and GPG Keys
5. cat ~/.ssh/id_rsa.pub
6. [Copy] SSH Keys to New SSH Keys on the Git page
# How to download darknet_ros
1. git clone --recursive git@github.com:leggedrobotics/darknet_ros.git
2. catkin build darknet_ros -DCMAKE_BUILD_TYPE=Release
- from https://github.com/leggedrobotics/darknet_ros
