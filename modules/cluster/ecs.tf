resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = "${var.app_name}-${var.environment}-capacity_provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.autoscale.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 4
      minimum_scaling_step_size = 2
      status                    = "ENABLED"
      target_capacity           = 10
    }
  }
}


/*
data "template_file" "cb_bot" {
  template = file(var.taskdef_template)
  vars = {
    app_image      = local.app_image
    app_port       = var.app_port
    #aws_region     = var.aws_region
    env            = var.environment
    app_name       = var.app_name
    image_tag      = var.image_tag
  }
}
*/
resource "aws_ecs_cluster" "aws-ecs-cluster" {
  depends_on = [
    aws_ecs_capacity_provider.capacity_provider
  ]
  name = "${var.app_name}-${var.environment}-cluster"
  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]
  tags = {
    Name = "${var.app_name}-${var.environment}-ecs"
  }
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${var.app_name}-${var.environment}-task"
  requires_compatibilities = ["EC2"]
  #container_definitions    = data.template_file.cb_bot.rendered
  container_definitions     = <<EOT
[
  {
    "name": "${var.app_name}-${var.environment}-container",
    "image": "${local.app_image}",
    "essential": true,
    "memory": 512,
    "cpu": 256,
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port},
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "VERSION",
        "value": "${var.image_tag}"
      }
    ]
  }
]
EOT
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

}


resource "aws_ecs_service" "main" {
  depends_on = [aws_alb_listener.listener, aws_iam_role.ecsTaskExecutionRole]
  name            = "${var.app_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition = aws_ecs_task_definition.aws-ecs-task.arn
  desired_count   = 2
  #launch_type     = "EC2"


  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
    weight = 1
    base = 0
  }


  network_configuration {
    security_groups  = [aws_security_group.security_group_port_i80.id]
    #have to be private
    subnets          = aws_subnet.public.*.id
    
    #assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.target_group.arn
    container_name   = "${var.app_name}-${var.environment}-container"
    container_port   = var.app_port
  }
}
