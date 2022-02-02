data "aws_caller_identity" "current" { }

data "aws_ssm_parameter" "bot_token" {
  name = var.ssm_parameter_token_name
}
data "aws_ssm_parameter" "bot_key" {
  name = var.ssm_parameter_key_name
}

