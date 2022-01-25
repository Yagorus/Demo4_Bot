resource "aws_alb" "application_load_balancer" {
  name               = "${var.app_name}-${var.environment}-alb"
  internal           = false
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.security_group_port_i80.id]
  tags = {
    Name        = "${var.app_name}-${var.environment}-alb"
  }
}

resource "aws_alb_target_group" "target_group" {
  name        = "${var.app_name}-${var.environment}-tg"
  port        = var.app_port
  protocol    = "HTTP"
  #target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    healthy_threshold   = "3"
    interval            = "5"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
  tags = {
    Name   = "${var.app_name}-${var.environment}-alb-tg"
  }
}
resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = var.app_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.id
  }
}