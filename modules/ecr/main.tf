resource "aws_ecr_repository" "ecr_repository" {
  name = local.aws_ecr_name
}

resource "aws_ssm_parameter" "token" {
  name  = "BOT_TOKEN"
  type  = "String"
  value = var.bot_token
  tags = {
    Name = "${var.app_name}-${environment}-token"
  }
}

resource "aws_ssm_parameter" "key" {
  name  = "API_KEY"
  type  = "String"
  value = var.bot_key
  tags = {
    Name = "${var.app_name}-${environment}-key"
  }
}