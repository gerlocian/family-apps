resource "aws_api_gateway_rest_api" "rest_api" {
  name = "ISBNLookup"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = ""
}

resource "aws_api_gateway_method" "http_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.http_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  passthrough_behavior    = "NEVER"
  uri                     = "arn:aws:apigateway:us-east-1:states:action/StartExecution"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = ["aws_api_gateway_integration.integration"]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = "dev"
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "dev"
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}