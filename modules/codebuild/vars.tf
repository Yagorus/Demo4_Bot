variable "aws_region" { }
variable "aws_profile" { }
variable "environment" { }
variable "app_name" { }
variable "bucket_name" {}
variable "buildspec_path" {}
variable "branch_githook" {}
variable "github_path" {}

#var from outputs ecs module
variable "subnets" {
  type        = list(string)
  default     = null
  description = "The subnet IDs that include resources used by CodeBuild"
}

variable "security_groups" {
  type        = list(string)
  default     = null
  description = "The security group IDs used by CodeBuild to allow access to resources in the VPC"
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "The VPC ID that CodeBuild uses"
}