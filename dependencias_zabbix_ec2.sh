#!/bin/bash
sudo yum update -y
sudo yum install yum-util git telnet -y
sudo amazon-linux-extras install docker -y
sudo usermod -aG docker ec2-user 
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo systemctl enable --now docker
sudo mkdir -p /var/local/storage && sudo chmod 775 /var/local/storage
sudo mkdir -p /var/local/storage/mysql_dump/var/lib/init && sudo chmod 775 /var/local/storage/mysql_dump/var/lib/init
cd /tmp && git clone https://github.com/brancomrt/bootcamp-clc7.git && cd /tmp/bootcamp-clc7 && cp -a dump.sql /var/local/storage/mysql_dump/var/lib/init && docker-compose up -d
sudo hostnamectl set-hostname zabbix-server.localdomain
sudo sed -i -e '$a\' -e 'preserve_hostname: true' /etc/cloud/cloud.cfg
cat >> /etc/hosts <<EOF
10.0.1.100  zabbix-server
10.0.1.101  web-server
EOF