locals {

environment = "dev"
app_name = "bot"
aws_profile = "default"
aws_account = "367668710117"
aws_region = "eu-central-1"
image_tag = "0.0.1"
az_count = 2
#branch_githook  = "terragrunt"
buildspec_path = "providers/dev"
}

inputs = {
    environment = local.environment
    app_name = local.apapp_namep
    aws_profile = local.aws_profile
    aws_account = local.aws_account
    aws_region = local.aws_region
    image_tag = local.image_tag
    az_count = local.az_count
    #branch_githook = local.branch_githook
    buildspec_path = local.buildspec_path
}

remote_state {
    backend = "s3" 

    config = {
        encrypt = true
        bucket = "s3-${local.app}-${local.env}"
        key =  format("%s/terraform.tfstate", path_relative_to_include())
        region = local.aws_region
  }
}
