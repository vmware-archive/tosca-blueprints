#!/bin/bash

export LC_ALL=C
cd ${HOME}
wget -c -v https://github.com/cloudify-cosmo/nodecellar/archive/master.tar.gz
tar -xvf master.tar.gz
cd nodecellar-master && npm update
rm -f ${HOME}/nodecellar.conf

echo -e "description 'nodecellar service'
# used to be: start on startup
# until we found some mounts were not ready yet while booting
start on started mountall
stop on shutdown
# Automatically Respawn:
respawn
respawn limit 99 5
setuid ubuntu
setgid ubuntu
script
    export NODECELLAR_PORT=8080
    export MONGO_PORT=27017
    export MONGO_HOST=${MONGO_HOST}
    exec /usr/bin/nodejs ${HOME}/nodecellar-master/server.js 2>&1
end script\n" >> ${HOME}/nodecellar.conf

init-checkconf -d ${HOME}/nodecellar.conf

sudo cp ${HOME}/nodecellar.conf /etc/init/nodecellar.conf

sudo chown root:root /etc/init/nodecellar.conf

# run service

sudo initctl start nodecellar
