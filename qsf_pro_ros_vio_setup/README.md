# How to Set up QSF Pro (Qualcomm Snapdragon Flight Pro)

## Flash BSP(Board Support Package) on the QSF Pro
> Connect QSF Pro using micro usb 2.0 type b (data cable for Android)
> It will reset the QSF Pro
1. Download JFlash File from Google Drive
```
mkdir ~/qsf_pro && cd ~/qsf_pro
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1SHqVo3W6zNKas3e4Rmd6cXlMqIbWd0Nh' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1SHqVo3W6zNKas3e4Rmd6cXlMqIbWd0Nh" -O 'QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2.zip' && rm -rf /tmp/cookies.txt
```
2. unzip & flash
```
unzip QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2.zip
cd QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2
chmod +x jflash.sh
./jflash.sh
```

## Install Machine Vision & Navigator SDK
1. Download Machine Vision SDK from Google Drive
```
cd ~/qsf_pro
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1MTOlafF6N1Yv3CKvzXxbzaD72gCfhhsG' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1MTOlafF6N1Yv3CKvzXxbzaD72gCfhhsG" -O 'mv_1.1.9_8x96.ipk' && rm -rf /tmp/cookies.txt
```
2. Copy and Install Machine Vision SDK using adb
```
sudo apt install adb
adb shell mkdir -p /data/bin
adb push mv_1.1.9_8x96.ipk /data/bin
adb shell opkg install /data/bin/mv_1.1.9_8x96.ipk
```
3. How to get license file
> Open the link below -> Create an acount -> Log in -> Download Navigator SDK File (Same as 5. Navigator SDK) -> Wait 1-2 business days for email with lisence file

> https://developer.qualcomm.com/software/qualcomm-navigator/tools
4. Import license file to the QSF Pro
```
adb shell mkdir -p /opt/qcom-licenses
adb push snapdragon-flight-license.bin /opt/qcom-licenses/
```
5. Download Navigator SDK from Google Drive
```
cd ~/qsf_pro
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=10dmV6-uhf4TLD3qancQXwVm2z8zTPr1e' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=10dmV6-uhf4TLD3qancQXwVm2z8zTPr1e" -O 'snav_1.2.59_8x96.ipk' && rm -rf /tmp/cookies.txt
```
6. Copy and Install Navigator SDK using adb
```
adb shell mkdir -p /data/bin
adb push snav_1.2.59_8x96.ipk /data/bin
adb shell opkg install /data/bin/snav_1.2.59_8x96.ipk
adb shell /etc/snav/enable_snav.sh
```
7. Create symbolic link & Start Navigator
```
adb shell ln -s /usr/lib/rfsa/adsp/200qc_runtime_params.xml /usr/lib/rfsa/adsp/snav_params.xml
adb shell start snav
```
8. Sensor Calibration
> The first one is for sensor calibration and the second one is for thermal calibration. The QSF Pro should be on a level surface during these calibrations.
```
snav_calibration_manager -s
snav_calibration_manager -t 5
```

## Install Docker Image for Development on Host Computer
