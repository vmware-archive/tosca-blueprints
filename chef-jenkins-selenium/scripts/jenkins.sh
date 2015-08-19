#!/bin/bash

set -e
set -o xtrace

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo echo deb http://pkg.jenkins-ci.org/debian binary/ > sudo /etc/apt/sources.list.d/jenkins.list
sudo apt-get install -y apache2 openjdk-7-jdk jenkins
