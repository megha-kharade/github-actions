terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5"
}

############################
# IAM Role
############################

resource "aws_iam_role" "lambda_role" {
  name = "incident-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "lambda.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

############################
# CloudWatch Logs Policy
############################

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

############################
# Lambda Function
############################

resource "aws_lambda_function" "python_lambda" {

  function_name = "test-github-actions"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"
  handler = "lambda_function.lambda_handler"

  filename         = "../lambda.zip"
  source_code_hash = filebase64sha256("../lambda.zip")

  timeout     = 30
  memory_size = 256

  environment {
    variables = {
      ENVIRONMENT = "dev"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs
  ]
}