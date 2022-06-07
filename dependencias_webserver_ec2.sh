#!/bin/bash
sudo yum update -y
sudo yum install yum-utils net-snmp-utils net-snmp telnet -y
sudo yum install https://repo.zabbix.com/zabbix/5.4/rhel/7/x86_64/zabbix-release-5.4-1.el7.noarch.rpm -y
sudo yum install zabbix-agent2 -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable --now nginx
sudo hostnamectl set-hostname web-server.localdomain
sudo sed -i -e '$a\' -e 'preserve_hostname: true' /etc/cloud/cloud.cfg
sudo sed -i -e '$a\' -e 'rocommunity bootcamp' /etc/snmp/snmpd.conf
sudo systemctl enable --now snmpd
sudo sed -i s/Server=127.0.0.1/Server=127.0.0.1,zabbix-server/g /etc/zabbix/zabbix_agent2.conf
sudo systemctl enable --now zabbix-agent2
cat >> /etc/hosts <<EOF
10.0.1.100  zabbix-server
10.0.1.101  web-server
EOF