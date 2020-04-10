# BossMonster_X56K_LV.64
Install Ubuntu on the BossMonster X56K LV.64
- GTX960M, Optimus

# Solve the problem that the screen stop
1. Boot using Ubuntu installer usb
2. Check the grub screen and the options 'Try Ubuntu without installing', 'Install Ubuntu'
3. press 'e' and change 'quiet splash ---' to 'quiet splash nomodeset'

# Solve the problem permanently
4. sudo gedit /etc/default/grub
5. change 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' to 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"'
6. sudo update-grub
7. sudo reboot now

# Install nvidia graphic driver
8. sudo apt-get purge nvidia*
9. sudo add-apt-repository ppa:graphics-drivers/ppa
10. sudo apt update
11. ubuntu-drivers devices | grep "nvidia-driver"
12. sudo apt install nvidia-driver-390
13. lsmod | grep nvidia
14. sudo reboot now

# Solve the problem optimus caused
15. sudo update-initramfs -u
16. sudo gedit /etc/default/grub
17. remove 'nomodeset'
18. sudo update-grub
19. sudo reboot now

# Check the nvidia driver is installed correctely
20. nvidia-smi
