
resource "aws_vpc" "XPIX-vpc" { # .tf uses this name
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "XPIX-vpc" # the actual name
  }
}

import {
  to = aws_vpc.XPIX-vpc
  id = "vpc-0700a195b9e85e1c7"
}

# Subnet 1
resource "aws_subnet" "XPIX-subnet-public1-us-east-1a" {
  vpc_id = aws_vpc.XPIX-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.0.0/20"
  tags = {
    Name = "XPIX-subnet-public1-us-east-1a"
  }
}

import {
  to = aws_subnet.XPIX-subnet-public1-us-east-1a
  id = "subnet-0352251c31451be7d"
}

# Subnet 2
resource "aws_subnet" "XPIX-subnet-public2-us-east-1b"{
  vpc_id = aws_vpc.XPIX-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "192.168.16.0/20"
  tags = {
    Name = "XPIX-subnet-public2-us-east-1b"
  }
}

import {
  to = aws_subnet.XPIX-subnet-public2-us-east-1b
  id = "subnet-0296d790f8422f280"
}

# Subnet 3
resource "aws_subnet" "XPIX-subnet-private1-us-east-1a"{
  vpc_id = aws_vpc.XPIX-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.128.0/20"
  tags = {
    Name = "XPIX-subnet-private1-us-east-1a"
  }
}

import {
  to = aws_subnet.XPIX-subnet-private1-us-east-1a
  id = "subnet-0850e1b345b723e4b"
}

# Subnet 4
resource "aws_subnet" "XPIX-subnet-private2-us-east-1b" {
  vpc_id = aws_vpc.XPIX-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "192.168.144.0/20"
  tags = {
    Name = "XPIX-subnet-private2-us-east-1b"
  }
}

import {
  to = aws_subnet.XPIX-subnet-private2-us-east-1b
  id = "subnet-0d7aee48de93f1cb3"
}

resource "aws_internet_gateway" "XPIX-igw" {
    vpc_id = aws_vpc.XPIX-vpc.id
    tags = {
        Name = "XPIX-igw"
    }
}

import {
  to = aws_internet_gateway.XPIX-igw
  id = "igw-0f75a058ee7494cc1"
}

# RT1
resource "aws_route_table" "XPIX-rtb-public" {
    vpc_id = aws_vpc.XPIX-vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.XPIX-igw.id
    }
    tags = {
        Name = "XPIX-rtb-public"
    }
}
  
import {
  to = aws_route_table.XPIX-rtb-public
  id = "rtb-0709a8a8a0e0bf447"
}

# RT2
resource "aws_route_table" "XPIX-rtb-private1-us-east-1a" {
    vpc_id = aws_vpc.XPIX-vpc.id
}

import {
  to = aws_route_table.XPIX-rtb-private1-us-east-1a
  id = "rtb-0925bd22623f99872"
}
# RT3
resource "aws_route_table" "XPIX-rtb-private2-us-east-1b" {
    vpc_id = aws_vpc.XPIX-vpc.id
}

import {
  to = aws_route_table.XPIX-rtb-private2-us-east-1b
  id = "rtb-0a02fffac4634693e"
}
# The two RTA's that route from the two public subnets to the public route table.
resource "aws_route_table_association" "public-subnet1-rta" { 
  subnet_id = aws_subnet.XPIX-subnet-public1-us-east-1a.id
  route_table_id = "rtb-0709a8a8a0e0bf447"
}

import {
  to = aws_route_table_association.public-subnet1-rta
  id = "subnet-0352251c31451be7d/rtb-0709a8a8a0e0bf447"
}
resource "aws_route_table_association" "public-subnet2-rta" {
  subnet_id = aws_subnet.XPIX-subnet-public2-us-east-1b.id
  route_table_id = "rtb-0709a8a8a0e0bf447"
}

import {
  to = aws_route_table_association.public-subnet2-rta
  id = "subnet-0296d790f8422f280/rtb-0709a8a8a0e0bf447"
}
# One RTA for each of the two private subnets routing to their own route table.

resource "aws_route_table_association" "private-subnet1-rta" {
  subnet_id = aws_subnet.XPIX-subnet-private1-us-east-1a.id
  route_table_id = "rtb-0925bd22623f99872"
}

import {
  to = aws_route_table_association.private-subnet1-rta
  id = "subnet-0850e1b345b723e4b/rtb-0925bd22623f99872"
}
resource "aws_route_table_association" "private-subnet2-rta" {
  subnet_id = aws_route_table.XPIX-rtb-private2-us-east-1b.id
  route_table_id = "rtb-0a02fffac4634693e"
}

import {
  to = aws_route_table_association.private-subnet2-rta
  id = "subnet-0d7aee48de93f1cb3/rtb-0a02fffac4634693e"
} 
resource "aws_security_group" "xpix-app-server" {
  name = "xpix-app-server"
  description = "This allows XPix app server connections."
  vpc_id = aws_vpc.XPIX-vpc.id
  tags = {
    Name = "xpix-app-server"
  }
}

import {
  to = aws_security_group.xpix-app-server
  id = "sg-08d19ce9dab6f2f9b"
}
resource "aws_vpc_security_group_ingress_rule" "xpix-app-server-ingress" {
  security_group_id = aws_security_group.xpix-app-server.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

import {
  to = aws_vpc_security_group_ingress_rule.xpix-app-server-ingress
  id = "sgr-0a5be222aed440d0b"
}