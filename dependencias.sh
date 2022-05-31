#!/bin/bash
sudo yum update -y
sudo yum install yum-utils -y
sudo amazon-linux-extras install docker -y
sudo usermod -aG docker ec2-user 
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo systemctl enable --now docker
sudo dnf install git -y