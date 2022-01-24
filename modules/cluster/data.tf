data "aws_availability_zones" "available" { }

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_ami" "latest_amazon_linux"{
    owners  =   ["amazon"]
    most_recent = true
        filter {
            name = "name"
            values   =  ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]    
        }
}
