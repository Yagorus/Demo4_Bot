
terraform {
    source = "../../../modules//codebuild"
}

include {
    path = find_in_parent_folders()
}
/*
locals {
  secrets = read_terragrunt_config(find_in_parent_folders(".secrets.hcl"))
}
*/

dependency "cluster" {
    config_path = "../cluster"
    mock_outputs = {
        vpc_id = "vpc-000000000000"
        subnets = ["subnet-222222222222", "subnet-333333333333"]
      
  }
}

dependency "ecr" {
    config_path = "../ecr"
    mock_outputs = {
      ecr_repository_url = "000000000000.dkr.ecr.eu-west-1.amazonaws.com/image"
  }
}

inputs = {
  local.secrets.inputs,
  {
    vpc_id = dependency.cluster.outputs.vpc_id
    subnets = dependency.cluster.outputs.subnets
    ecr_repository_url = dependency.ecr.outputs.ecr_repository_url
  }
}

