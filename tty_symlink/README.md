# Set the /dev/tty* to custom tty name like /dev/ttyWeeBee
1. cd /etc/udev/rules.d
2. sudo gedit 99-weebee.rules
3. reboot or ```sudo udevadm control --reload-rules && udevadm trigger```

# Add the below lines
```
SUBSYSTEM=="tty", ATTRS{idVendor}=="idVendor", ATTRS{idProduct}=="idProduct", ATTRS{serial}=="serial", SYMLINK+="ttyWeeBee", MODE="0666"
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="A506LNAR", SYMLINK+="ttyPixhawk", MODE="0666"
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="A506LPEJ", SYMLINK+="ttySTM32Duino", MODE="0666"
```

# How to check the information
1. idVendor and id Product are from 'lsusb'
```
lsusb
```
2. serial is from 'udevadm info -a -n /dev/ttyUSB*'
```
udevadm info -a -n /dev/ttyUSB*
```
3. SYMLINK is the custom tty name
4. MODE is for the autority. It is for serial communication on the computer including embedded PC.
