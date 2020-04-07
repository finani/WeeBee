# Set WOL (Wake on Lan) on Ubuntu

1. sudo apt-get install net-tools ethtool
2. lfconfig
- Check the name of the interface (enp4s0 for now)
3. sudo ethtool enp4s0
- Check the value of 'wake-on' is 'g' or not ('d' means disable)
4. sudo ethtool -s enp4s0 wol g
5. sudo gedit /etc/network/interfaces
```
up ethtool -s enp4s0 wol g
```
