terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.usregion
  access_key = var.accesskey
  secret_key = var.secretkey
  token = var.token
}

# Creation of VPC
resource "aws_vpc" "VPC-A" {
    cidr_block = var.vpc_cidr_blockA
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = { Name = "vpc-${var.vpc_name[0]}"}
}

# Creation of Internet Gateway
resource "aws_internet_gateway" "IGW-A" {
    vpc_id = aws_vpc.VPC-A.id
    tags   = { Name = var.igw_name}
}

# Configuration of public routing table 1
resource "aws_route_table" "RT-public1A" {
    vpc_id = aws_vpc.VPC-A.id
    route {
        cidr_block = var.cidr_block
        gateway_id = aws_internet_gateway.IGW-A.id
    }
    tags = { Name = "${var.prt_name[0]}" }
}

# Configuration of public routing table 2
resource "aws_route_table" "RT-public2A" {
    vpc_id = aws_vpc.VPC-A.id
    route {
        cidr_block = var.cidr_block
        gateway_id = aws_internet_gateway.IGW-A.id
    }
    tags = { Name = "${var.prt_name[1]}" }
}

# Association of public subnet 1 with public routing table 1
resource "aws_route_table_association" "public1A" {
    subnet_id      = aws_subnet.SN-public-1A.id
    route_table_id = aws_route_table.RT-public1A.id
}

# Association of public subnet 2 with public routing table 2
resource "aws_route_table_association" "public2A" {
    subnet_id      = aws_subnet.SN-public-2A.id
    route_table_id = aws_route_table.RT-public2A.id
}

# AWS EC2 Instance 1
resource "aws_instance" "terraformed" {
  ami = var.ami-id
  instance_type = var.instance_name
  subnet_id = aws_subnet.SN-public-1A.id
  tags = { Name = "${var.ws_name[0]}" }
}

# AWS EC2 Instance 2
resource "aws_instance" "terraformed2" {
  ami = var.ami-id
  instance_type = var.instance_name
  subnet_id = aws_subnet.SN-public-2A.id
  tags = { Name = var.ws_name[1] }
}

# Creation of public subnet 1
resource "aws_subnet" "SN-public-1A" {
    vpc_id = aws_vpc.VPC-A.id
    cidr_block = var.subnet_prefixA[0]
    map_public_ip_on_launch = true
    availability_zone = var.azone[0]
    tags = { Name = "${var.psubnet_name[0]}" }
}

# Creation of public subnet 2
resource "aws_subnet" "SN-public-2A" {
    vpc_id = aws_vpc.VPC-A.id
    cidr_block = var.subnet_prefixA[1]
    map_public_ip_on_launch = true
    availability_zone = var.azone[1]
    tags = { Name = "${var.psubnet_name[1]}" }
}

# Creation of private subnet 1
resource "aws_subnet" "SN-private-1A" {
    vpc_id = aws_vpc.VPC-A.id
    cidr_block = var.subnet_prefixA[2]
    map_public_ip_on_launch = true
    availability_zone = var.azone[2]
    tags = { Name = "${var.prvsubnet_name[0]}" }
}

# Creation of private subnet 2
resource "aws_subnet" "SN-private-2A" {
    vpc_id = aws_vpc.VPC-A.id
    cidr_block = var.subnet_prefixA[3]
    map_public_ip_on_launch = true
    availability_zone = var.azone[3]
    tags = { Name = "${var.prvsubnet_name[1]}" }
}
################ VPC-B Resources ########################
# Creation of VPC
resource "aws_vpc" "VPC-B" {
    cidr_block = var.vpc_cidr_blockB
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = { Name = "vpc-${var.vpc_name[1]}"}
}

# Creation of Internet Gateway
resource "aws_internet_gateway" "IGW-B" {
    vpc_id = aws_vpc.VPC-B.id
    tags   = { Name = var.igw_name}
}

# Configuration of public routing table 1
resource "aws_route_table" "RT-public1B" {
    vpc_id = aws_vpc.VPC-B.id
    route {
        cidr_block = var.cidr_block
        gateway_id = aws_internet_gateway.IGW-B.id
    }
    tags = { Name = "${var.prt_name[0]}" }
}

# Configuration of public routing table 2
resource "aws_route_table" "RT-public2B" {
    vpc_id = aws_vpc.VPC-B.id
    route {
        cidr_block = var.cidr_block
        gateway_id = aws_internet_gateway.IGW-B.id
    }
    tags = { Name = "${var.prt_name[1]}"}
}

# Association of public subnet 1B with public routing table 1B
resource "aws_route_table_association" "public1B" {
    subnet_id      = aws_subnet.SN-public-1B.id
    route_table_id = aws_route_table.RT-public1B.id
}

# Association of public subnet 2B with public routing table 2B
resource "aws_route_table_association" "public2B" {
    subnet_id      = aws_subnet.SN-public-2B.id
    route_table_id = aws_route_table.RT-public2B.id
}

# AWS EC2 Instance 3
resource "aws_instance" "terraformed3" {
  ami = var.ami-id
  instance_type = var.instance_name
  subnet_id = aws_subnet.SN-public-1B.id
  tags = { "name" = "${var.ws_name[0]}" }
}

# AWS EC2 Instance 4
resource "aws_instance" "terraformed4" {
  ami = var.ami-id
  instance_type = var.instance_name
  subnet_id = aws_subnet.SN-public-2B.id
  tags = { "name" = "${var.ws_name[1]}"}
}

# Creation of public subnet 1 - B
resource "aws_subnet" "SN-public-1B" {
    vpc_id = aws_vpc.VPC-B.id
    cidr_block = var.subnet_prefixB[0]
    map_public_ip_on_launch = true
    availability_zone = var.azone[0]
    tags = { Name = "${var.psubnet_name[0]}" }
}

# Creation of public subnet 2 - B
resource "aws_subnet" "SN-public-2B" {
    vpc_id = aws_vpc.VPC-B.id
    cidr_block = var.subnet_prefixB[1]
    map_public_ip_on_launch = true
    availability_zone = var.azone[1]
    tags = { Name = "${var.psubnet_name[1]}"}
}

# Creation of private subnet 1 - B
resource "aws_subnet" "SN-private-1B" {
    vpc_id = aws_vpc.VPC-B.id
    cidr_block = var.subnet_prefixB[2]
    map_public_ip_on_launch = true
    availability_zone = var.azone[2]
    tags = { Name = "${var.prvsubnet_name[0]}" }
}

# Creation of private subnet 2 - B
resource "aws_subnet" "SN-private-2B" {
    vpc_id = aws_vpc.VPC-B.id
    cidr_block = var.subnet_prefixB[3]
    map_public_ip_on_launch = true
    availability_zone = var.azone[3]
    tags = { Name = "${var.prvsubnet_name[1]}" }
}
