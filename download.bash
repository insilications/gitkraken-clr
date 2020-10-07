#!/usr/bin/env bash

# Try to locate the original rpm under current directory
echo -e "\e[33m\xe2\x8f\xb3 Locating gitkraken-amd64.rpm...\e[m"
VERSION="$(curl -L --silent 'https://www.gitkraken.com/download' | grep -oP "(?<=Latest\srelease:\s)(\d+)(\.\d+)+")"
DOWNLOADURL="https://release.gitkraken.com/linux/gitkraken-amd64.rpm"
echo -e "\e[33m\xE2\x9C\x93 latest version is: $VERSION"
echo -e "\e[33m\xE2\x9C\x93 download URL is: $DOWNLOADURL"
curl -L -C - -O $DOWNLOADURL
INSTALLER="$(find . -maxdepth 1 | sort -r | grep --max-count=1 -oP "\.\/gitkraken-amd64.rpm")"
if [ "$INSTALLER" = '' ]; then
## Cannot download or find installer
    echo -e "\e[31m\xe2\x9d\x8c Cannot download or find gitkraken-amd64.rpm under current directory\e[m"
    exit 1
else
    echo -e "\e[33m\xE2\x9C\x93 Found gitkraken-amd64.rpm\e[m"
    rpm2cpio gitkraken-amd64.rpm | cpio -ivdm --directory=$PWD
fi
