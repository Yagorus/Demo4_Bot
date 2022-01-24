/*
resource "aws_launch_configuration" "launch" {
    depends_on  = [aws_security_group.security_group_port_i80]
    security_groups = [aws_security_group.security_group_port_i80.id]
    name = "launch"
    #user_data = file("user_data.sh")
    lifecycle {
      create_before_destroy = true
    }
    image_id = data.aws_ami.latest_amazon_linux.id
    instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "app" { 
  depends_on                = [aws_launch_configuration.launch]
  name                      = "${var.app_name}-${var.environment}-auto-asg"
  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 2
  health_check_type         = "EC2"
  launch_configuration      = aws_launch_configuration.launch.name
  vpc_zone_identifier       = [for subnet in aws_subnet.public : subnet.id]
  #load_balancers            = [aws_alb.application_load_balancer.id]
  target_group_arns         = [aws_alb_target_group.target_group.arn]

  tag {
    key                 = "Name"
    value               = "${var.app_name}-${var.environment}-ec2"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "name" {
  autoscaling_group_name = aws_autoscaling_group.app.name
  alb_target_group_arn  =  aws_alb_target_group.target_group.arn
}
*/

resource "aws_launch_configuration" "ecs_launch_config" {
    image_id             = data.aws_ami.latest_amazon_linux.id
    iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
    security_groups      = [aws_security_group.security_group_port_i80.id]
    user_data            = "#!/bin/bash\necho ECS_CLUSTER=my-cluster >> /etc/ecs/ecs.config"
    instance_type        = "t2.micro"

    tag {
    key                 = "Name"
    value               = "${var.app_name}-${var.environment}-ec2"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
    depends_on                = [aws_launch_configuration.launch]
    name                      = "${var.app_name}-${var.environment}-auto-asg"
    vpc_zone_identifier       = [for subnet in aws_subnet.public : subnet.id]
    launch_configuration      = aws_launch_configuration.ecs_launch_config.name

    desired_capacity          = 2
    min_size                  = 1
    max_size                  = 2
    health_check_grace_period = 300
    health_check_type         = "EC2"
}