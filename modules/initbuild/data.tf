data "aws_caller_identity" "current" { }

data "aws_ssm_parameter" "bot_token" {
  name = aws_ssm_parameter.token.name
}
data "aws_ssm_parameter" "bot_key" {
  name = aws_ssm_parameter.key.name
}

