#!/bin/bash

sudo apt install mysql-server -y
sudo service mysql start
sudo mysql -u root <<-EOF
CREATE USER 'jaime'@'localhost' IDENTIFIED BY ''; #crea usuario en mysql
GRANT ALL PRIVILEGES ON * . * TO 'jaime'@'localhost'; #da maximos privilegios al usuario creado
flush privileges; #reinicia todos los permisos para aplicar cambios
create database web; #crea DB para el login web
use web;
CREATE TABLE usuarios(nombre VARCHAR(30),apellidos VARCHAR(30),user VARCHAR(30) PRIMARY KEY UNIQUE,pas>
INSERT INTO usuarios (nombre, apellidos, user, password) VALUES ('test', 'test', 'test@test.es', 'test>
EOF

sudo rm -r /var/www/html/*
sudo mv /TFG_AWS/* /var/www/html
sudo mv /var/www/html/sign-up-login-form/dist/* /var/www/html
