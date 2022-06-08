module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bootcamp-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.2.0/24"]
  public_subnets  = ["10.0.1.0/24"]
  

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Environment = "Producao"
    OwnerSquad = "Houston"
    OwnerSRE = "Texas"
    Team = "Devops-CLC_07"
  }
}

module "zabbix_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Zabbix-SG"
  description = "Security group para instancia do Zabbix Server"
  vpc_id      = module.vpc.vpc_id   
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "http-8080-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

module "zabbix_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Zabbix-Server"

  ami                    = "ami-03ededff12e34e59e"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  monitoring             = true
  private_ip             = "10.0.1.100"
  vpc_security_group_ids = [module.zabbix_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("./dependencias_zabbix_ec2.sh")

  tags = {
    Terraform = "true"
    Environment = "Bootcamp"
    OwnerSquad = "Houston"
    OwnerSRE = "Texas"
    Team = "Devops-CLC_07"    
  } 
}

resource "aws_eip" "zabbix-ip" {
  instance = module.zabbix_instance.id
  vpc      = true

  tags = {
    Name = "Zabbix-Server-ElasticIP"
  }
}

module "webserver_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "WebServer-SG"
  description = "Security group para instancia do Web Server NGINX"
  vpc_id      = module.vpc.vpc_id   
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "all-icmp"]
  ingress_with_cidr_blocks = [
    {
      from_port = 10050
      to_port   = 10050
      protocol  = "tcp"
      description = "zabbix-10050-tcp"
      cidr_blocks = "10.0.1.0/24"
    },
    {
      from_port = 161
      to_port   = 161
      protocol  = "udp"
      description = "snmp-161-udp"
      cidr_blocks = "10.0.1.0/24"
    }
  ]
  egress_rules        = ["all-all"]
}

module "webserver_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Web-Server"

  ami                    = "ami-03ededff12e34e59e"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  monitoring             = true
  private_ip             = "10.0.1.101"
  vpc_security_group_ids = [module.webserver_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("./dependencias_webserver_ec2.sh")

  tags = {
    Terraform = "true"
    Environment = "Producao"
    OwnerSquad = "Houston"
    OwnerSRE = "Texas"
    Team = "Devops-CLC_07"    
  } 
}

resource "aws_eip" "webserver-ip" {
  instance = module.webserver_instance.id
  vpc      = true

  tags = {
    Name = "WebServer-ElasticIP"
  }
}