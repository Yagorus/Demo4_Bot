variable "aws_region" { }
variable "aws_profile" { }
variable "environment" { }
variable "app_name" { }
variable "bucket_name" {}

variable "bot_token" { }
variable "bot_key" { }

locals {
  aws_ecr_name = format("%s-%s", var.app_name, var.environment)
}
