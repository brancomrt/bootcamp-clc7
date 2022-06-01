#!/bin/bash
sudo yum update -y
sudo yum install yum-utils -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable --now nginx
sudo hostnamectl set-hostname webserver.localdomain
sudo sed -i -e '$a\' -e 'preserve_hostname: true' /etc/cloud/cloud.cfg