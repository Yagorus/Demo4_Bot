variable "aws_region" { }
variable "aws_profile" { }
variable "environment" { }
variable "app_name" { }

#variable "remote_state_bucket" {}


locals {
  aws_ecr_name = format("%s-%s", var.app_name, var.environment)
}