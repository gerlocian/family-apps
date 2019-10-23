output "lambda-arn" {
  description = "The ARN value assigned to the lambda after deployment."
  value       = aws_lambda_function.lambda.arn
}
