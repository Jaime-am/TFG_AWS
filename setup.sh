#!/bin/bash

sudo apt install apache2 -y
sudo apt install mysql-server -y
sudo apt install php -y
sudo apt install php-mysqli -y
sudo mv 20-mysqli.ini /etc/php/8.1/apache2/conf.d/

#Creamos un usuario www-data y lo añadimos al grupo www-data
#para que pueda gestionar Apache la carpeta uploads
sudo mkdir /var/www/html/uploads
sudo adduser www-data www-data
sudo chown -R www-data:www-data /var/www
sudo chmod -R g+rwX /var/www
sudo service apache2 restart

sudo service mysql start

sudo mysql -u root <<-EOF
CREATE USER 'jaime'@'localhost' IDENTIFIED BY ''; #crea usuario en mysql
GRANT ALL PRIVILEGES ON * . * TO 'jaime'@'localhost'; #da maximos privilegios al usuario creado
flush privileges; #reinicia todos los permisos para aplicar cambios
EOF

sudo mysql -u jaime <<-EOF
create database web; #crea DB para el login web
use web;
CREATE TABLE usuarios (nombre VARCHAR(30),apellidos VARCHAR(30),user VARCHAR(30) PRIMARY KEY UNIQUE,password VARCHAR(100));
INSERT INTO usuarios (nombre, apellidos, user, password) VALUES ('test', 'test', 'test@test.es', 'test');
EOF

sudo rm -r /var/www/html/*
sudo mv /TFG_AWS/* /var/www/html
sudo mv /var/www/html/sign-up-login-form/dist/* /var/www/html
