
### This project will provision a 3 Tiere , multi AZ infrastructure as code as below
![Project Objective](./images/tooling_project_16.png)


I created a new IAM user called Terraform and granted the user only programatic access with AdministrativeAccess.

I stored the Access ID key and Secret Key

I installed Python SDK (Boto3)

Next, I created an S3 bucket in the AWS console called dele-dev-terraform-bucket to store the Terraform state file

After this, I authenticated using aws configure using my key credentials
```
aws configure
```
I checked the configuration by listing my previously created 33 bucket
```
aws s3 list
```
```
MINGW64 ~/Documents/Terraform-IAC-3-Tier-Architecture-1 (main)
$ aws s3 ls
2022-09-19 12:18:38 dele-dev-terraform-bucket
```
LET'S START WRITING SOME CODE. I WILL DO THIS IN STEPS

I will start with:

1. VPC
2. Public Subnet for the NAT Gateway, proxy server and Bastion host
3. Private Subnets for webservers
4. private subnets for data layer

I will create main.tf to which will be our main file. I will intially hardcode values and later will refactor code

```
touch main.tf
```

### main.tf
```
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
### I will run terraform init to download all terraform aws dependencies
```
<<<<<<< HEAD
```
terraform init
```
I will run terraform init to download all terraform aws dependencies
Let's start creating the vpc's
```
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
```
=======
>>>>>>> 5fd0f1f811a9e88f5f6d3df7395096e9d0e8491f
