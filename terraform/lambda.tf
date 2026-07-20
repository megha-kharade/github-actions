resource "aws_lambda_function" "python_lambda" {

  function_name = "test-github-actions"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"

  handler = "lambda_function.lambda_handler"

  filename = "../lambda.zip"

  source_code_hash = filebase64sha256("../lambda.zip")

  timeout = 30

  memory_size = 256

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs
  ]
}