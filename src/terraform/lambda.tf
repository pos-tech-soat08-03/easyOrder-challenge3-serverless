
resource "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "./lambda_function"
  output_path = "./lambda_function.zip"
}

resource "aws_lambda_function" "cpf_lookup" {
  function_name    = "cpf_lookup"
  runtime          = "python3.8"
  role             = data.aws_iam_role.labrole.arn 
  handler          = "lambda_function.lambda_handler"
  filename         = archive_file.lambda_zip.output_path
  depends_on       = [archive_file.lambda_zip]
  source_code_hash = filebase64sha256("./lambda_function/lambda_function.py")
  publish          = true
  timeout           = 10
  memory_size       = 128
  environment {
    variables = {
      RDS_HOST     = data.terraform_remote_state.easyorder-database.outputs.rds_endpoint
      RDS_USERNAME = data.terraform_remote_state.easyorder-database.outputs.rds_username
      RDS_PASSWORD = data.terraform_remote_state.easyorder-database.outputs.rds_password
      RDS_DB_NAME  = data.terraform_remote_state.easyorder-database.outputs.rds_db_name
    }
  }
}
