data "aws_availability_zones" "available" { }
#ecs data role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
#launch ami
data "aws_ami" "latest_amazon_linux"{
    owners  =   ["amazon"]
    most_recent = true
        filter {
            name = "name"
            values   =  ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]    
        }
}
#auto scale data role 
data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}