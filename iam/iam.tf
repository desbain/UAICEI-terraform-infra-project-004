resource "aws_iam_role" "rds_secrets_manager_role" {
  name = "rds-secrets-manager-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "rds.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "rds-secrets-manager-policy"
  description = "Policy to allow RDS to access Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:jupiter_db_credentials-*" # Make changes here
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_manager_policy" {
  role       = aws_iam_role.rds_secrets_manager_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}