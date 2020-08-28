

resource "aws_lb" "webtier" {
  name               = "webtier"
  internal           = false
  load_balancer_type = "application"

  security_groups    = [aws_security_group.web.id]
  subnets            = [aws_subnet.websubnet1.id, aws_subnet.websubnet2.id]

  tags = {
    "stage" = "test"
    "env"   = "webtier"
  }
}

resource "aws_lb_target_group" "webtier" {
  name     = "webtier"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.webtier.id

  health_check {
    path    = "/"
    port    = 80
    matcher = "200,301"
  }

  tags = {
    "stage" = "test"
    "env"   = "webtier"
  }
}

resource "aws_lb_listener" "webtier" {
  load_balancer_arn = aws_lb.webtier.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-1:808057468350:certificate/c1f29f41-c14e-45de-9eac-1fda5115cce0"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webtier.arn
  }
}

resource "aws_lb_target_group_attachment" "webworker1" {
  target_group_arn = aws_lb_target_group.webtier.arn
  target_id        = aws_instance.webworker1.id
  port             = 80
}


resource "aws_lb_target_group_attachment" "webworker2" {
  target_group_arn = aws_lb_target_group.webtier.arn
  target_id        = aws_instance.webworker2.id
  port             = 80
}
