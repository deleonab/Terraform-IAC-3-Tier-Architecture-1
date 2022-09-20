# It's time to create the Internet gateway for the vpc

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s",aws_vpc.main.id,"IGW" )
  }
}