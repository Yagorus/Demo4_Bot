resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "make build"
    working_dir = var.working_dir
    environment = {
        TAG = var.image_tag
        REGISTRY_ID = data.aws_caller_identity.current.account_id
        REPOSITORY_REGION = var.aws_region
        APP_NAME = var.app_name
        ENV_NAME = var.environment
        BOT_TOKEN = data.aws_ssm_parameter.bot_token.value
        API_KEY = data.aws_ssm_parameter.bot_key.value
    }
  }
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