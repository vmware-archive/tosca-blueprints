#tasks/wordpress.py

from fabric.api import run, sudo
from cloudify import ctx
import time

def install(root_password, public_ip):   
    run('sudo apt-get -y update')
    ctx.logger.info('Installing packages')
    run('sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mysql-client')
    _set_root_password()
    ctx.logger.info('Installing wordpress')
    run('sudo apt-get -y install mysql-server wordpress')
    set_up_command = "sudo bash /usr/share/doc/wordpress/examples/setup-mysql -n {0} {1}".format(root_password, public_ip)
    ctx.logger.info('Running mysql-setup')
    run(set_up_command)
    run('sudo ln -s /usr/share/wordpress /var/www/wordpress')
    run('echo "ServerName localhost" | sudo tee /etc/apache2/httpd.conf')
    run('echo "ServerName localhost" | sudo tee /etc/apache2/conf.d/fqdn')
    
def start():
    ctx.logger.info('sudo /etc/init.d/apache2 restart')
    run('sudo /etc/init.d/apache2 restart')

def _set_root_password():
    root_password = ctx.node.properties['root_password']
    ctx.logger.info('Setting mysql root password to {0}'.format(root_password))
    root_password_command = "sudo debconf-set-selections <<< " \
                            "'mysql-server mysql-server/root_password password " \
                            "{0}'".format(root_password)
    root_password_again_command = "sudo debconf-set-selections <<< " \
                                  "'mysql-server mysql-server/root_password_again password " \
                                  "{0}'".format(root_password)

    sudo(root_password_command)
    sudo(root_password_again_command)