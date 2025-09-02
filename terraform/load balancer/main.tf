resource "aws_lb" "application_load_balancer" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
  ip_address_type    = "ipv4"
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "target_group" {
  name     = "java-app-target-group"
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
    port                = 80
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
