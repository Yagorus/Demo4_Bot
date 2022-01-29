terraform {
  source = "../../../modules//cluster"
}

dependencies {
    paths = ["../initbuild"]
}


dependency "ecr" {
    config_path = "../ecr"
    mock_outputs = {
      ecr_repository_url = "000000000000.dkr.ecr.eu-west-1.amazonaws.com/image"
      ecr_repository_url_page = "000000000000.dkr.ecr.eu-west-1.amazonaws.com/image"
  }
}

inputs = {
    ecr_repository_url = dependency.ecr.outputs.ecr_repository_url
}