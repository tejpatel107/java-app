provider "aws" {
  region = "us-east-1"
}

#---------------------
# VPC
#---------------------
module "vpc" {
  source     = "./vpc"
  cidr_block = "10.0.0.0/16"
}

#---------------------
# Public Subnets
#---------------------
module "public_subnet_1" {
  source     = "./subnets"
  vpc_id     = module.vpc.vpc-id
  cidr_block = "10.0.1.0/24"
  az         = "us-east-1a"
  name       = "public-subnet-1-1a"
  public     = true
}

module "public_subnet_2" {
  source     = "./subnets"
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.2.0/24"
  az         = "us-east-1b"
  name       = "public-subnet-2-1b"
  public     = true
}

module "public_subnet_3" {
  source     = "./subnets"
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.3.0/24"
  az         = "us-east-1c"
  name       = "public-subnet-3-1c"
  public     = true
}

#---------------------
# Private Subnets
#---------------------
module "private_subnet_1" {
  source     = "./subnets"
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.4.0/24"
  az         = "us-east-1d"
  name       = "private-subnet-1-1d"
  public     = false
}

module "private_subnet_2" {
  source     = "./subnets"
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.5.0/24"
  az         = "us-east-1e"
  name       = "private-subnet-2-1e"
  public     = false
}

module "private_subnet_3" {
  source     = "./subnets"
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.6.0/24"
  az         = "us-east-1f"
  name       = "private-subnet-3-1f"
  public     = false
}

#---------------------
# Public Security Group
#---------------------

# Public SG - allows HTTP 80 and SSH 22 from anywhere
module "public_security_group" {
  source      = "./security groups"
  name        = "java-app-vpc-public-sg"
  description = "Public security group for java app jump start server and load balancer"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = [
    { 
      from_port = 22, 
      to_port = 22, 
      protocol = "tcp", 
      cidr_blocks = ["0.0.0.0/0"], 
      description = "SSH from anywhere" 
    },
    { 
      from_port = 80, 
      to_port = 80, 
      protocol = "tcp", 
      cidr_blocks = ["0.0.0.0/0"], 
      description = "HTTP from anywhere" },
  ]
}

# Private SG - allows SSH from public SG, HTTP 8080 from anywhere (LB)
module "private_security_group" {
  source      = "./security groups"
  name        = "java-app-vpc-public-sg"
  description = "Private security groups for EC2 instances"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = [
    { 
      from_port = 22, 
      to_port = 22, 
      protocol = "tcp", 
      security_groups = [module.public_security_group.sg_id], 
      description = "SSH from public SG" 
    },
    { 
      from_port = 8080, 
      to_port = 8080, 
      protocol = "tcp", 
      security_groups = [module.public_security_group.sg_id], 
      description = "HTTP 8080 from load balancer" },
  ]
}

# RDS SG - allows Postgres 5432 from private SG and public SG
module "rds_security_group" {
  source      = "./security groups"
  name        = "java-app-vpc-rds-sg"
  description = "Security group for RDS instances"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = [
    { 
      from_port = 5432, 
      to_port = 5432, 
      protocol = "tcp", 
      security_groups = [module.sg_private.sg_id, module.sg_public.sg_id], description = "Postgres access from app servers" 
    }
  ]
}
