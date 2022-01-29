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
  working_dir = format("%s/../../../app-test", get_terragrunt_dir())
}
