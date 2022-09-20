resource "aws_lb" "ext-alb" {
  name               = "ext-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ext-alb-sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]
  ip_address_type = "ipv4"
  enable_deletion_protection = true

    tags = {
    Name = "ACM-ext-alb"
  }
}



# Target group for ALB. 443 as secure ssl

resource "aws_lb_target_group" "nginx-tg" {
  name     = "nginx-tg"
  port     = 443
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id   = aws_vpc.main.id


  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}






resource "aws_lb_listener" "nginx-listener" {
  load_balancer_arn = aws_lb.fext-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  
  certificate_arn   = "aws_acm_certificate_validation.workachoo.certificate_arn"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tg.arn
    }
}


