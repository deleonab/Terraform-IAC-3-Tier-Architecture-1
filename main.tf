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
# I will run terraform init to download all terraform aws dependencies
## Let's start creating the vpc's

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-2a"
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-2b"
  tags = {
    Name = "public-subnet-2"
  }
}

Next, I will refactor the code to remove the hardcoded variables.