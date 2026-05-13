//data source used to get the availability zones that are available in the region
data "aws_availability_zones" "current"{
 state = "available"
}

//used to provide the common naming for the resources 
locals {
    naming = slice(data.aws_availability_zones.current.names, 0, var.az_count)
}

resource "aws_vpc" "vpc"{
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
    Name = "main-vpc"
  }

}