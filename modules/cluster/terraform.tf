provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = var.bucket_name
    region  = var.aws_region
    key     = "state"
  }
}
