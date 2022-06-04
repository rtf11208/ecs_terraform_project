resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ecs_security_group]
  subnets            = [var.private_subnet_id_a,var.private_subnet_id_b]

  enable_deletion_protection = false

  tags = {
    Environment = "${var.vpc_name}-${var.env}-ecs_load_balancer"
  }
}

resource "aws_lb_target_group" "ecs_alb_target_group" {
  name     = "ecs-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold     = "2"
    unhealthy_threshold   = "3"
    interval              = "30"
    protocol              = "HTTP"
    port                  = "traffic-port"
    timeout               = "29"
    path                  = "/"
    matcher               = "200"
  }
}

resource "aws_alb_listener" "ecs_alb_listener"  {
  load_balancer_arn = aws_lb.test.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs_alb_target_group.arn
  }
}



