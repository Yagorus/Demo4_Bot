provider "aws" {
    region = var.aws_region
    profile = var.aws_profile
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "bot-dev-s3"
    region  = "eu-central-1"
    key     = "state"
  }
}
