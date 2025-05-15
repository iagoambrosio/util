#!/bin/sh
  PACKAGE=python3
  YUM_CMD=$(whereis yum)
  APT_GET_CMD=$(which apt-get)
  PACMAN_CMD=$(which pacman)
  EMERGE_CMD=$(which emerge)
  ZYPP_CMD=$(which zypper)
  APK_CMD=$(which apk)
 if [[ ! -z $YUM_CMD ]]; then
    yum install -y $PACKAGE
 elif [[ ! -z $APT_GET_CMD ]]; then
    apt-get install $PACKAGE
 elif [[ ! -z $PACMAN_CMD ]]; then
    pacman -Sy $PACKAGE
 elif [[ ! -z $EMERGE_CMD ]]; then 
    emerge --ask dev-lang/python:3.8
 elif [[ ! -z $APK_CMD ]]; then
    apk add $PACKAGE
 elif [[ ! -z $ZYPP_CMD ]]; then
    zypper install -y $PACKAGE
 else
    echo "error can't install package $PACKAGE"
    exit 1;
 fi
