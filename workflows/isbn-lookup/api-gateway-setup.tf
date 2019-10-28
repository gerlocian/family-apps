resource "aws_api_gateway_rest_api" "rest_api" {
  name = "ISBNLookup"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "isbn"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = ["aws_api_gateway_integration.integration"]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "develop"
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}