# Define variables
variable "usregion" {
    description = "AWS region"
    type = string 
}

variable "accesskey" {
    description = "Access key"
    type = string 
}

variable "secretkey" {
    description = "Secret key"
    type = string 
}

variable "token" {
    description = "Token"
    type = string 
}

variable "vpc_cidr_blockA" {
    description = "vpc address space for VPC-A"
    type = string
}

variable "subnet_prefixA" {
    description = "subnet prefixes for VPC-A"
    type = list
}

variable "vpc_cidr_blockB" {
    description = "vpc address space for VPC-B"
    type = string
}

variable "subnet_prefixB" {
    description = "subnet prefixes for VPC-B"
    type = list
}

variable "azone" {
    description = "availability zones"
    type = list
}

variable "ami-id" {
    description = "id of AWS AMI"
    type = string
}

variable "vpc_name" {
    description = "VPC name"
    type = list(string)
}

variable "igw_name" {
    description = "Internet Gateway Name"
    type = string
}

variable "prt_name" {
    description = "Public Routing Table Names"
    type = list(string)
}

variable "ws_name" {
    description = "Names of Web-Servers"
    type = list(string)
}

variable "psubnet_name" {
    description = "Public Subnet Name"
    type = list(string)
}

variable "prvsubnet_name" {
    description = "Private Subnet Name"
    type = list(string)
}

variable "instance_name" {
    description = "Instance Name"
    type = string
}

variable "cidr_block" {
    description = "Default CIDR block"
    type = string
}
