# BossMonster_X56K_LV.64
Install Ubuntu on the BossMonster X56K LV.64
- GTX960M, Optimus

# Solve the problem that the screen stop
1. Boot using Ubuntu installer usb
2. Check the grub screen and the options 'Try Ubuntu without installing', 'Install Ubuntu'
3. press 'e' and change 'quiet splash ---' to 'quiet splash nomodeset'

# Solve the problem permanently
1. sudo gedit /etc/default/grub
2. change 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' to 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"'
3. sudo update-grub
4. sudo reboot now

# Install nvidia graphic driver
1. sudo apt-get purge nvidia*
2. sudo add-apt-repository ppa:graphics-drivers/ppa
3. sudo apt update
4. ubuntu-drivers devices | grep "nvidia-driver"
5. sudo apt install nvidia-driver-390
6. lsmod | grep nvidia
7. sudo reboot now

# Solve the problem optimus caused
1. sudo update-initramfs -u
2. sudo gedit /etc/default/grub
3. remove 'nomodeset'
4. sudo update-grub
5. sudo reboot now

# Check the nvidia driver is installed correctely
1. nvidia-smi
