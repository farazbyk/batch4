provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
  profile = "default"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_vpc}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.environment_tag}"
  }
}

resource "aws_subnet" "public" {    # Creating Public Subnets
  count = "${length(var.subnet_cidrs_public)}"
  vpc_id =  aws_vpc.vpc.id
  cidr_block = "${var.subnet_cidrs_public[count.index]}"        # CIDR block of public subnets
   availability_zone = "${var.availability_zones[count.index]}"
}


resource "aws_subnet" "private" {    # Creating Public Subnets
  count = "${length(var.subnet_cidrs_private)}"
  vpc_id =  aws_vpc.vpc.id
  cidr_block = "${var.subnet_cidrs_private[count.index]}"        # CIDR block of public subnets
   availability_zone = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.vpc.id               # vpc_id will be generated after we create VPC
}

resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.vpc.id
        route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
    }
}

resource "aws_eip" "nat1" {
  depends_on = [aws_internet_gateway.IGW]
}

resource "aws_nat_gateway" "nat_gw" {
  subnet_id     = aws_subnet.public[0].id
   allocation_id = aws_eip.nat1.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.IGW]
}

  
resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
  vpc_id = aws_vpc.vpc.id
  route {
  cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
  nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}


resource "aws_route_table_association" "PublicRTassociation" {
    count = "${length(var.subnet_cidrs_public)}"

    subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = aws_route_table.PublicRT.id

}

resource "aws_route_table_association" "PrivateRTassociation" {
    count = "${length(var.subnet_cidrs_private)}"
     subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
#    subnet_id = aws_subnet.privatesubnets.id
    route_table_id = aws_route_table.PrivateRT.id
}
