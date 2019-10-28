data "aws_iam_role" "step_function_lambda_execution" {
  name = "StepFunctionsLambdaExecution"
}

data "aws_iam_role" "api_gateway_role" {
  name = "APIGatewayToStepFunctions"
}

data "aws_lambda_function" "isbn_lookup" {
  function_name = yamldecode(file("../../services/isbn-lookup/isbn-lookup.yml")).functionName
}

data "aws_lambda_function" "isbn_map" {
  function_name = yamldecode(file("../../services/isbn-map/isbn-map.yml")).functionName
}

data "aws_lambda_function" "response_200" {
  function_name = yamldecode(file("../../services/200-response/200-response.yml")).functionName
}

data "aws_lambda_function" "response_500" {
  function_name = yamldecode(file("../../services/500-response/500-response.yml")).functionName
}