output "ecr_repository_url" {
  value = aws_ecr_repository.ecr_repository.repository_url
}

output "ssm_parameter_token_name" {
  value = aws_ssm_parameter.token.name
}
output "ssm_parameter_key_name" {
  value = aws_ssm_parameter.key.name
}