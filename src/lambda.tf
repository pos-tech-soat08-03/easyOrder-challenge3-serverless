
resource "aws_lambda_function" "cpf_lookup" {
  filename         = "lambda_function.zip"
  function_name    = "cpf_lookup"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("lambda_function.zip")

# todo trocar as variaveis para data externo
  environment {
    variables = {
      RDS_HOST     = var.rds_host
      RDS_USERNAME = var.db_username
      RDS_PASSWORD = var.db_password
      RDS_DB_NAME  = var.db_name
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}