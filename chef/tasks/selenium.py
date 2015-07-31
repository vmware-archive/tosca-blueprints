#tasks/selenium.py

from fabric.api import run, sudo, settings
from StringIO import StringIO
from cloudify import ctx

def install():
	with settings(warn_only=True):
		sudo('apt-get install -y firefox xvfb')
		sudo('mkdir /usr/lib/selenium || :')
		ctx.logger.info('Update packages')
		run('cd /usr/lib/selenium')
		ctx.logger.info('Download apache and jdk')
		sudo('wget http://selenium-release.storage.googleapis.com/2.46/selenium-server-standalone-2.46.0.jar')
		sudo('ln -s selenium-server-standalone-2.43.1.jar selenium-server-standalone.jar')
		sudo('nohup Xvfb :99 -ac &')
		run('DISPLAY=:99 nohup java -jar selenium-server-standalone-2.46.0.jar &')