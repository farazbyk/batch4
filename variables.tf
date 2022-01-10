variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default = "10.1.0.0/24"
}
variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "us-east-2a"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "hotfix-sherdil"
}

variable "private_subnets" {
  type = string
  default = "10.1.3.0/24"
}

variable "private_subnets1" {
  type = string
  default = "10.1.4.0/24"
}

variable "public_subnets" {
  type = string
  default = "10.1.5.0/24"
}

variable "public_subnets1" {
  type = string
  default = "10.1.6.0/24"
}

variable "subnet_cidrs_public" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default = ["10.1.5.0/24", "10.1.6.0/24"]
  type = list(string)
}

variable "subnet_cidrs_private" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default = ["10.1.3.0/24", "10.1.4.0/24"]
  type = list(string)
}

variable "availability_zones" {
  description = "AZs in this region to use"
  default = ["us-east-1a", "us-east-1c"]
  type = list(string)
}
