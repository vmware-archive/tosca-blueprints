#!/bin/bash

set -e
set -o xtrace

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive

# see http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" \
    | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

sudo apt-get update
sudo apt-get install -y mongodb-org

# the following config changes are needed: smallfiles set to true, and bind_ip
# set to default
sudo sed -i '/bind_ip/d' /etc/mongod.conf
sudo sed -i '/smallfiles/d' /etc/mongod.conf
echo 'smallfiles = true' | sudo tee /etc/mongod.conf
