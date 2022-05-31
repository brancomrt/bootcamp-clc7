module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bootcamp-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  public_subnets  = ["10.0.1.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = false

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
  ingress_rules       = ["ssh-tcp", "http-8080-tcp"]
  egress_rules        = ["all-all"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Zabbix-Server"

  ami                    = "ami-03ededff12e34e59e"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  monitoring             = true
  vpc_security_group_ids = [module.zabbix_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("./dependencias.sh")

  tags = {
    Terraform = "true"
    Environment = "Producao"
    OwnerSquad = "Houston"
    OwnerSRE = "Texas"
    Team = "Devops-CLC_07"    
  } 
}

resource "aws_eip" "zabbix-ip" {
  instance = module.ec2_instance.id
  vpc      = true

  tags = {
    Name = "Zabbix-Server-ElasticIP"
  }
}