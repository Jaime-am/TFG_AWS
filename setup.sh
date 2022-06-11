#!/bin/bash

sudo apt install mysql-server mariadb-server -y
sudo service mysql start
sudo service mariadb start
sudo rm -r /var/www/html/*
sudo mv /TFG_AWS/* /var/www/html
sudo mv /var/www/html/sign-up-login-form/dist/* /var/www/html
