resource "aws_eip" "eip" {
  vpc = true
  depends_on                = [aws_internet_gateway.igw]
}


resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}