
resource "aws_vpc" "XPIX-vpc" { # .tf uses this name
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "XPIX-vpc" # the actual name
  }
}

# Subnet 1
resource "aws_subnet" "XPIX-subnet-private1-us-east-1a"{
  vpc_id = aws_vpc.XPIX-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.128.0/20"
  tags = {
    Name = "XPIX-subnet-private1-us-east-1a"
  }
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
# Subnet 3
resource "aws_subnet" "XPIX-subnet-public1-us-east-1a" {
  vpc_id = aws_vpc.XPIX-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.0.0/20"
  tags = {
    Name = "XPIX-subnet-public1-us-east-1a"
  }
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

resource "aws_internet_gateway" "XPIX-igw" {
    vpc_id = aws_vpc.XPIX-vpc.id
    tags = {
        Name = "XPIX-igw"
    }
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
    
# RT2
resource "aws_route_table" "XPIX-rtb-private2-us-east-1b" {
    vpc_id = aws_vpc.XPIX-vpc.id
}

# RT3
resource "aws_route_table" "XPIX-rtb-private1-us-east-1a" {
    vpc_id = aws_vpc.XPIX-vpc.id
}

# A1 https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "XPIX-rtb-private1-us-east-1" {
  
}

# A2
resource "aws_route_table_association" "XPIX-subnet-public2-us-east-1b" {
  
}

resource "aws_security_group" "name" {
  
}

resource "aws_vpc_security_group_ingress_rule" "name" {
  
}