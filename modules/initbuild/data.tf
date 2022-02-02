data "aws_caller_identity" "current" { }

data "aws_ssm_parameter" "bot_token" {
  name = aws_ssm_parameter.token.name
}
data "aws_ssm_parameter" "bot_key" {
  name = aws_ssm_parameter.key.name
}

resource "aws_ssm_parameter" "token" {
  name  = "BOT_TOKEN"
  type  = "String"
  value = var.bot_token
  tags = {
    Name = "${var.app_name}-${var.environment}-token"
  }
}

resource "aws_ssm_parameter" "key" {
  name  = "API_KEY"
  type  = "String"
  value = var.bot_key
  tags = {
    Name = "${var.app_name}-${var.environment}-key"
  }
}