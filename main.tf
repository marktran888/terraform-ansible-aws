provider "aws" {
  region = "${var.aws_region}"
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
