#!/bin/bash
sudo yum update -y
sudo yum install yum-utils -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable --now nginx
sudo hostnamectl set-hostname webserver.localdomain
sudo sed -i -e '$a\' -e 'preserve_hostname: true' /etc/cloud/cloud.cfg
sudo yum install https://repo.zabbix.com/zabbix/5.4/rhel/7/x86_64/zabbix-release-5.4-1.el7.noarch.rpm
sudo yum install zabbix-agent2 -y
net-snmp net-snmp-utils -y
sudo sed -i -e '$a\' -e 'rocommunity atech' /etc/snmp/snmpd.conf
sudo systemctl enable --now snmpd
sudo echo "Server=127.0.0.1,10.0.1.100" /etc/zabbix/zabbix_agent2.d/01-bootcamp
