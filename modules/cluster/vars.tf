
/*==========global vars==========*/
variable "aws_region" { }
variable "aws_profile" { }
#variable "remote_state_bucket" {}
variable "environment" { }
variable "app_name" { }
variable "image_tag" { }
variable "ecr_repository_url" { }
variable "app_count" { }

variable "taskdef_template" {
  default = "../../modules/cluster/cb_bot.json.tpl"
}


/*==========local vars==========*/
variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}


variable "cidr_block_vpc" {
  default = "10.0.0.0/16"
}
variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "health_check_path" {
  default = "/"
}
#============================================#
/*
variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}
variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "TaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "ECS task role name"
  default = "TaskRole"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role Name"
  default = "AutoScaleRole"
}
*/
#============================================#

locals {
  app_image = format("%s:%s", var.ecr_repository_url, var.image_tag)
}