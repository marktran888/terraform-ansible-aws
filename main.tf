provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

#VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"
}

#Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main"
  }
}

#Route Table
resource "aws_route_table" "public_r" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "public"
  }
}

resource "aws_default_route_table" "private_r" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"

  tags {
    Name = "private"
  }
}

#Subnet
resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_public_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone = "${var.availability_zone_public}"

  tags {
    Name = "public"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_private1_cidr_block}"
  map_public_ip_on_launch = false
  availability_zone = "${var.availability_zone_private1}"

  tags {
    Name = "private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_private2_cidr_block}"
  map_public_ip_on_launch = false
  availability_zone = "${var.availability_zone_private2}"

  tags {
    Name = "private2"
  }
}

resource "aws_subnet" "rds1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_private3_cidr_block}"
  map_public_ip_on_launch = false
  availability_zone = "${var.availability_zone_private1}"

  tags {
    Name = "rds1"
  }
}

resource "aws_subnet" "rds2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_private4_cidr_block}"
  map_public_ip_on_launch = false
  availability_zone = "${var.availability_zone_private2}"

  tags {
    Name = "rds2"
  }
}

resource "aws_subnet" "rds3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_private5_cidr_block}"
  map_public_ip_on_launch = false
  availability_zone = "${var.availability_zone_public}"

  tags {
    Name = "rds3"
  }
}

#Subnet Associations
resource "aws_route_table_association" "public_a" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.publc.id}"
}

resource "aws_route_table_association" "private1_a" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private2_a" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.public.id}"
}
