resource "aws_eip" "nat_eip" {
  vpc = true
  depends_on                = [aws_internet_gateway.igw]
   tags = {
    Name = format("%s-%s",aws_vpc.main.id,"EIP")
  }
}


resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id,0)
 # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
   tags = {
    Name = format("%s-%s",aws_vpc.main.id,"NATGW")
  }
}