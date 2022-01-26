#try local
variable "bucket_name" {
  type        = string
  description = "S3 Bucket name"
  default     = "bot-dev-eu-west-1-bucket"
}
#
variable "environment" { }
variable "app_name" { }
variable "aws_profile" { }
variable "aws_account" { }
variable "aws_region" { }
variable "image_tag" { }

    #define branch in git hub
#variable "repo_url" { }
#variable "branch_pattern" { }
#variable "git_trigger_event" { }
    #get from github | creds to access
#variable "github_oauth_token" { }
    #count of containers
variable "app_count" { }


