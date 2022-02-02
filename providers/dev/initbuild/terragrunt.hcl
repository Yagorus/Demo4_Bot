terraform {
  source = "../../../modules//initbuild"
}

include {
  path = find_in_parent_folders()
}

dependency "ecr" {
  config_path = "../ecr"
  skip_outputs = true
}

inputs = {
  working_dir = format("%s/../../../bot", get_terragrunt_dir())
  ssm_parameter_token_name = dependency.ecr.outputs.ssm_parameter_token_name
  ssm_parameter_key_name = dependency.ecr.outputs.ssm_parameter_key_name
}