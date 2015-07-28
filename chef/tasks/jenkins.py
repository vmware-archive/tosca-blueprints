#tasks/jenkins.py

from fabric.api import run, sudo, settings
from StringIO import StringIO
from cloudify import ctx

def install():
	with settings(warn_only=True):
		sudo('apt-get -y update')
		sudo('wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -')
		sudo('echo deb http://pkg.jenkins-ci.org/debian binary/ > sudo /etc/apt/sources.list.d/jenkins.list')
		ctx.logger.info('Download apache and jdk')
		sudo('apt-get install -y apache2 openjdk-7-jdk jenkins')