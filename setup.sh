#!/bin/bash

sudo apt install apache2 -y
sudo apt install mysql-server -y
sudo apt install php -y
sudo apt install php-mysqli -y
sudo mv 20-mysqli.ini /etc/php/8.1/apache2/conf.d/
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

sudo mysql -u jaime <<-EOF

DROP TABLE IF EXISTS `form`;
CREATE TABLE IF NOT EXISTS `form` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `apellidos` varchar(200) NOT NULL,
  `archivo_nombre` varchar(200) NOT NULL,
  `archivo_tipo` varchar(200) NOT NULL,
  `archivo_binario` longblob NOT NULL
  `comentarios` varchar(200) NOT NULL,
);
EOF

sudo rm -r /var/www/html/*
sudo mv /TFG_AWS/* /var/www/html
sudo mv /var/www/html/sign-up-login-form/dist/* /var/www/html
