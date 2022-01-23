
data "template_file" "cb_bot" {
  template = file(var.taskdef_template)
  vars = {
    app_image      = local.app_image
    app_port       = var.app_port
    aws_region     = var.aws_region
    env            = var.environment
    app_name       = var.app_name
    image_tag      = var.image_tag
  }
}

resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.app_name}-${var.environment}-cluster"
  tags = {
    Name = "${var.app_name}-${var.environment}-ecs"
  }
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${var.app_name}-${var.environment}-task"
  requires_compatibilities = ["EC2"]
  container_definitions    = data.template_file.cb_bot.rendered
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
}


resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition = aws_ecs_task_definition.aws-ecs-task.arn
  desired_count   = 2
  launch_type     = "EC2"


  network_configuration {
    security_groups  = [aws_security_group.security_group_port_i80.id]
    #have to be private
    subnets          = aws_subnet.public.*.id
    #! must be false if private subnets !
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.target_group.arn
    container_name   = "${var.app_name}-${var.environment}-container"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.listener, aws_iam_role.ecsTaskExecutionRole]
}
