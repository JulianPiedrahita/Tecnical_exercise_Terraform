resource "aws_lb" "web" {
  name               = "web-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.server.id]
  subnets            = module.network.public_subnets

  enable_deletion_protection = false

  tags = {
    Name = "web-tf"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "web-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }

}

resource "aws_lb_listener_rule" "web" {
  listener_arn = aws_lb_listener.web.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}