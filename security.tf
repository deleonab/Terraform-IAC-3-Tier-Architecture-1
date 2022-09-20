resource "aws_security_group" "ext-alb-sg" {
  name        = "ext-alb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "ext-alb-sg"
  }
}



resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Allow TLS inbound traffic frm ALB"
  vpc_id      = aws_vpc.main.id

   ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "bastion-sg"
  }
}



resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "Allow TLS inbound traffic from ALB"
  vpc_id      = aws_vpc.main.id

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "nginx-sg"
  }
}

resource "aws_security_group_rule" "nginx-sg-rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = aws_security_group.ext-alb-sg.id
  security_group_id = aws_security_group.nginx-sg.id
}



resource "aws_security_group" "int-alb-sg" {
  name        = "int-alb-sg"
  description = "Allow TLS inbound traffic from nginx"
  vpc_id      = aws_vpc.main.id

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "int-alb-sg"
  }
}

resource "aws_security_group_rule" "int-alb-rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = aws_security_group.nginx-sg.id
  security_group_id = aws_security_group.int-alb-sg.id
}

