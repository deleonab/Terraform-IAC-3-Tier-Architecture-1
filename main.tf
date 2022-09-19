# Configure the AWS Provider. Our provider is AWS for this project
provider "aws" {
  region = "eu-west-2"
}

# Now that we have specified the provider, it is time to start creating the resources. The first resource will be the VPC

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_classiclink = false
  enable_classiclink_dns_support = false
  
    tags = {
    Name = "main VPC"
  }
}