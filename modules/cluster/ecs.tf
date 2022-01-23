/*
resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.app_name}-${var.environment}-cluster"
  tags = {
    Name = "${var.app_name}-${var.environment}-ecs"
  }
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${var.app_name}-${var.environment}-task"
  requires_compatibilities = ["EC2"]


  network_mode             = "awsvpc"
}
*/