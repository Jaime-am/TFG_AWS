#!/bin/bash

sudo rm -r /var/www/html/*
sudo mv -r /TFG_AWS/* /var/www/html
sudo mv -r /var/www/html/sign-up-login-form/dist/* /var/www/html
