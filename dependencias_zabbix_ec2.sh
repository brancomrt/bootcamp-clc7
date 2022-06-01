#!/bin/bash
sudo yum update -y
sudo yum install yum-utils -y
sudo amazon-linux-extras install docker -y
sudo usermod -aG docker ec2-user 
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo systemctl enable --now docker
sudo yum install git -y
#sudo mkdir -p /var/local/storage && sudo chmod 755 /var/local/storage
cd /tmp && git clone https://github.com/brancomrt/bootcamp-clc7.git && cd /tmp/bootcamp-clc7 && docker-compose up -d
sudo hostnamectl set-hostname zabbix-server.localdomain
sudo sed -i -e '$a\' -e 'preserve_hostname: true' /etc/cloud/cloud.cfg