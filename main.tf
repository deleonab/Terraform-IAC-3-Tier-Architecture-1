# Configure the AWS Provider. Our provider is AWS for this project
provider "aws" {
  region = var.region
}

# Get the number of availability zones in th region

data "aws_availability_zones" "available" {
  state = "available"
}
# az_count = length(data.aws_availability_zones.available.names)
# Now that we have specified the provider, it is time to start creating the resources. The first resource will be the VPC

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink = var.enable_classiclink
  enable_classiclink_dns_support = var.enable_classiclink_dns_support
  
    tags = {
    Name = "main VPC"
  }
}
# I will run terraform init to download all terraform aws dependencies
## Let's start creating the vpc's

resource "aws_subnet" "public" {
    # count is number of public subnets required
  count =  var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr,4,count.index)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "public-subnet -${count.index}"
  }
}


#Next, I will create 4 private subnets
resource "aws_subnet" "private" {
  count = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr,4,count.index +2)
  map_public_ip_on_launch = false
  # error invalid index, given index is greater than collection - got fixed by wrapping the AZ list in an element function
  availability_zone = element(data.aws_availability_zones.available.names[*],count.index)
  tags = {
    Name = "private-subnet-${count.index}"
  }
}

