sudo apt-get -y update

#install apache & modules
sudo DEBIAN_FRONTEND=noninteractive sudo apt-get -y install apache2 libapache2-mod-php debconf-i18n

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password access33"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password access33"
sudo apt-get -y install mysql-server
# create database
sudo mysql -h127.0.0.1 -uroot -ppromodo33 -e "create database db;"

# install php7
sudo apt-get -y install php
# install extensions
sudo apt-get -y install libapache2-mod-php php-bcmath php-cli php-curl php-gd php-json php-ldap php-mbstring php-mysql php-pdo php-pear php-xml php-zip

# install Apache config & SSL
sudo mkdir "/var/www/html/public"
sudo  mkdir /etc/apache2/ssl
cd /etc/apache2/ssl
sudo openssl req -x509 -newkey rsa:4096 -keyout apache.key -out apache.crt -days 3650 -nodes -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com/emailAddress=me@mydomain.com"
cd ~

# setup virtual domain
# Configure Apache
sudo echo "<Directory var/www/>
AllowOverride All
Options All
</Directory>

<VirtualHost *:80>
    ServerName project.promodo.local
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/public
    ErrorLog /error.log
    CustomLog /access.log combined
</VirtualHost>

<VirtualHost *:443>
    ServerName project.promodo.local
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/public
    ErrorLog /error.log
    CustomLog /access.log combined
	SSLEngine on
	SSLCertificateFile /etc/apache2/ssl/apache.crt
	SSLCertificateKeyFile /etc/apache2/ssl/apache.key
</VirtualHost>" > /tmp/site.conf

sudo cp /tmp/site.conf /etc/apache2/sites-available/000-default.conf
sudo a2ensite 000-default.conf

# restart services
sudo a2enmod rewrite
sudo a2enmod ssl
sudo service apache2 restart

sudo chown -R $USER:$USER /var/www/*
sudo rm  var/www/html/index.html

# install Composer
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Addons
sudo apt-get -y install git supervisor mc nano
# Addons END
