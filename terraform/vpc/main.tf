terraform {
  required_version = ">=0.12"
}

# vpc
resource "aws_vpc" "vpc" {

  tags = {
    Name = var.name
  }

  cidr_block = var.cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

}

# internet gateway
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.ig_name}-igw"
  }
}
