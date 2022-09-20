
resource "aws_route_table" "rtb-private" {
  vpc_id = aws_vpc.main.id

  
  tags = {
    Name = "Private-RT"
  }
}

resource "aws_route" "rtb-private-route" {
  route_table_id         = aws_route_table.rtb-private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.natgw.id
}
# associate all private subnets to the private route table

resource "aws_route_table_association" "rt-assoc-private" {
  count          = length(aws_subnet.private[*].id)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.rtb-private.id
}



resource "aws_route_table" "rtb-public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public-RT"
  }
}


resource "aws_route" "rtb-public-route" {
  route_table_id         = aws_route_table.rtb-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public[*].id)
  subnet_id      = element(aws_subnet.public[*].id,count.index)
  route_table_id = aws_route_table.rtb-public.id
}

