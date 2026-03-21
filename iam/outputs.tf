output "rds_secrets_manager" {
  value = aws_iam_role.rds_secrets_manager_role.arn
}