#!/bin/bash

set -e
set -o xtrace

export DEBIAN_FRONTEND=noninteractive

echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -c | awk '{print $2}'`-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -qy install postgresql-9.3 pgadmin3

