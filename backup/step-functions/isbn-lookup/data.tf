data "aws_iam_role" "step_function_lambda_execution" {
  name = "StepFunctionsLambdaExecution"
}

data "aws_lambda_function" "compress" {
  function_name = yamldecode(file("../../lambdas/compress/compress.yml")).functionName
}

data "aws_lambda_function" "decompress" {
  function_name = yamldecode(file("../../lambdas/decompress/decompress.yml")).functionName
}

data "aws_lambda_function" "isbn_lookup" {
  function_name = yamldecode(file("../../lambdas/isbn-lookup/isbn-lookup.yml")).functionName
}

data "aws_lambda_function" "isbn_map" {
  function_name = yamldecode(file("../../lambdas/isbn-map/isbn-map.yml")).functionName
}
