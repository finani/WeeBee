# How to Set up QSF Pro (Qualcomm Snapdragon Flight Pro)

## How to Flash BSP(Board Support Package) on the QSF Pro
> Connect QSF Pro using micro usb 2.0 type b (data cable for Android)
1. Download JFlash File
```
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1SHqVo3W6zNKas3e4Rmd6cXlMqIbWd0Nh' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1SHqVo3W6zNKas3e4Rmd6cXlMqIbWd0Nh" -O 'QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2.zip' && rm -rf /tmp/cookies.txt
```
2. unzip QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2.zip
3. cd QualcommFlightPro_APQ8096-LE-1-0-1-r00032.2
4. chmod +x jflash.sh
5. ./jflash.sh

## How to Install docker image on Host Computer
