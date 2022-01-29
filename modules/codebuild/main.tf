resource "aws_codebuild_project" "project" {
  depends_on = []
  name = "${var.app_name}-${var.environment}-code-build-project"
  description = "test"
  build_timeout = "10"
  service_role = aws_iam_role.code_build_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
}

# https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html
# https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html

  environment {
    compute_type = "BUILD_GENERAL1_SMALL" # 7 GB memory
    image = "aws/codebuild/standard:4.0"
    type = "LINUX_CONTAINER"
    # The privileged flag must be set so that your project has the required Docker permissions
    privileged_mode = true

    environment_variable {
      name = "deploy"
      value = "true"
    }
  }

  source {
    buildspec = var.buildspec_path
    type = "GITHUB"
    location = var.github_path
    git_clone_depth = 1
    report_build_status = "true"
  }
vpc_config {
    vpc_id = var.vpc_id
    subnets = var.subnets
    security_group_ids = [ aws_security_group.codebuild_sg.id ]
  }
}