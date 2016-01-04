#/bin/bash

# Installing ruby v2 with rvm
set -x

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

which curl >/dev/null 2>&1
if  [ $? != 0 ]; then
  yum -y install curl >/dev/null 2>&1
fi

yum groupinstall -y 'development tools'

which rvm >/dev/null 2>&1

if  [ $? != 0 ]; then
  curl -L get.rvm.io | bash -s stable >/dev/null 2>&1
fi

curl -sSL https://rvm.io/mpapis.asc | sudo gpg2 --import -
 
curl -L get.rvm.io | bash -s stable

sleep 5

source /etc/profile.d/rvm.sh

rvm reload

echo " rvm install ruby 2.1.0 "

rvm install 2.1.0

ruby --version

echo " Installed rubies "

rvm list rubies

echo " Setting 2.1.0 as default "

rvm use 2.1.0 --default

echo " updating ruby "

gem update

gem update --system
