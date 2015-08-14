#!/bin/bash

set -e
set -o xtrace

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive

sudo apt-get install -y firefox xvfb
sudo mkdir /usr/lib/selenium || :
cd /usr/lib/selenium
sudo wget http://selenium-release.storage.googleapis.com/2.46/selenium-server-standalone-2.46.0.jar
sudo ln -s selenium-server-standalone-2.43.1.jar selenium-server-standalone.jar
java -jar selenium-server-standalone-2.46.0.jar
