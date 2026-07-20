resource "aws_iam_role" "lambda_role" {

  name = "incident-lambda-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "lambda.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })
}

resource "aws_lambda_function" "incident" {

  function_name = "incident-management"

  filename = "../github-actions/lambda.zip"

  source_code_hash = filebase64sha256("../lambda.zip")

  handler = "lambda_function.lambda_handler"

  runtime = "python3.12"

  role = aws_iam_role.lambda_role.arn
}