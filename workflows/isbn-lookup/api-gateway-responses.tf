resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.http_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.http_method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
  selection_pattern = "-"
  content_handling  = "CONVERT_TO_TEXT"

//  response_templates = {
//    "application/json" = "$input.path('$')"
//  }
}

resource "aws_api_gateway_method_response" "response_500" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.http_method.http_method
  status_code = "500"
}

resource "aws_api_gateway_integration_response" "response_500" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.http_method.http_method
  status_code = aws_api_gateway_method_response.response_500.status_code
  selection_pattern = "500"
  content_handling  = "CONVERT_TO_TEXT"

//  response_templates = {
//    "application/json" = "$input.path('$')"
//  }
}

resource "aws_api_gateway_method_response" "response_404" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.http_method.http_method
  status_code = "404"
}

resource "aws_api_gateway_integration_response" "response_404" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.http_method.http_method
  status_code = aws_api_gateway_method_response.response_404.status_code
  selection_pattern = "404"
}

resource "aws_api_gateway_method_response" "response_400" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.http_method.http_method
  status_code = "400"
}

resource "aws_api_gateway_integration_response" "response_400" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.http_method.http_method
  status_code = aws_api_gateway_method_response.response_400.status_code
  selection_pattern = "400"
}