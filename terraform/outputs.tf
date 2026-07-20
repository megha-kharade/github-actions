output "lambda_name" {
  value = aws_lambda_function.python_lambda.function_name
}

output "lambda_arn" {
  value = aws_lambda_function.python_lambda.arn
}

output "iam_role" {
  value = aws_iam_role.lambda_role.name
}