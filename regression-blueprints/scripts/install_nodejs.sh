#!/bin/bash

export LC_ALL=C
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get update 2>&1
sudo apt-get install nodejs make g++ wget -q -y 2>&1
