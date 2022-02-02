terraform {
  source = "../../../modules//ecr"
}

include {
  path = find_in_parent_folders()
}

locals {
  #file secrets.hcl is placed in /module/code-build/ folder
  #secrets = read_terragrunt_config("../../../modules/codebuild/secrets.hcl")
  secrets = read_terragrunt_config(find_in_parent_folders("secrets.hcl"))
}
inputs = local.secrets.inputs