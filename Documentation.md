
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