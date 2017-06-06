provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

#VPC
resource "aws_vpc" "selected" {
  cidr_block = "${var.vpc_cidr_block}"
}
