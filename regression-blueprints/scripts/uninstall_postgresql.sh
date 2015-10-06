#!/bin/bash

set -e
set -o xtrace

export DEBIAN_FRONTEND=noninteractive

# drop postgresql
sudo apt-get -qy remove postgresql-9.3 pgadmin3

# cleanup repo
sudo rm /etc/apt/sources.list.d/pgdg.list
sudo apt-key del "PostgreSQL Debian Repository"
sudo apt-get update
