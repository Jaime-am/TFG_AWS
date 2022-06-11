#!/bin/bash

sudo apt install mysql-server -y
sudo service mysql start
sudo mysql -u root -e "CREATE USER 'jaime'@'localhost' IDENTIFIED BY '';" //crea usuario en mysql
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'jaime'@'localhost';" //da maximos privilegios al usuario creado
sudo mysql -u root -e "flush privileges;" //reinicia todos los permisos para aplicar cambios
sudo mysql -u root -e "create database web;" //crea DB para el login web


sudo rm -r /var/www/html/*
sudo mv /TFG_AWS/* /var/www/html
sudo mv /var/www/html/sign-up-login-form/dist/* /var/www/html
