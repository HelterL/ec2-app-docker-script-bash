#!/bin/bash

sudo apt update
sudo apt upgrade -y
curl -fsSL https://get.docker.com/ | sh
git clone https://github.com/denilsonbonatti/mundo-invertido.git
touch Dockerfile
echo -e "FROM httpd:2.4 \nCOPY ./mundo-invertido/ /usr/local/apache2/htdocs/" > Dockerfile
sudo docker build -t webserver .
sudo docker run -dit --name meu-webserver -p 80:80 webserver