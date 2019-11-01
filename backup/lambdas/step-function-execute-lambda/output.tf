output "lambda_arn" {
  description = "The ARN value assigned to the lambda after deployment."
  value       = module.step_function_execution_lambda.lambda_arn
}