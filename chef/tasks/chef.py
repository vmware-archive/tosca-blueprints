#tasks/chef.py

from fabric.api import run, sudo,settings
from StringIO import StringIO
from cloudify import ctx
import time

def install():
	with settings(warn_only=True):
		fh = StringIO();   
		sudo('apt-get -y update')
		ctx.logger.info('Download sdk')
		run('wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.6.2-1_amd64.deb')
		ctx.logger.info('Install the package')
		sudo('dpkg -i chefdk_0.6.2-1_amd64.deb', stdout=fh)

		for line in fh.readlines():
		    if(line == 'Thank you for installing Chef Development Kit!'):
		        ctx.logger.info('Installation complete')