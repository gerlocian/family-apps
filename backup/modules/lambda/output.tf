output "lambda_arn" {
  description = "The ARN value assigned to the lambda after deployment."
  value       = aws_lambda_function.lambda.arn
}

output "invoke_arn" {
  description = "The ARN value assigned to the lambdas execution."
  value       = aws_lambda_function.lambda.invoke_arn
}
