#!/bin/bash

sudo apt install mysql-server -y
sudo service mysql start
sudo mysql -u root -e "create database web;"

sudo rm -r /var/www/html/*
sudo mv /TFG_AWS/* /var/www/html
sudo mv /var/www/html/sign-up-login-form/dist/* /var/www/html
