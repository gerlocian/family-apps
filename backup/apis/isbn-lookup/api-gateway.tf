resource "aws_api_gateway_rest_api" "isbn_lookup_api" {
  name        = "IsbnLookupExecutionAPI"
  description = "An API for looking up a book by ISBN"
}

resource "aws_api_gateway_resource" "isbn_lookup_api" {
  rest_api_id = aws_api_gateway_rest_api.isbn_lookup_api.id
  parent_id   = aws_api_gateway_rest_api.isbn_lookup_api.root_resource_id
  path_part   = "isbn"
}

resource "aws_api_gateway_method" "isbn_lookup_api" {
  rest_api_id   = aws_api_gateway_rest_api.isbn_lookup_api.id
  resource_id   = aws_api_gateway_resource.isbn_lookup_api.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "isbn_lookup_api" {
  rest_api_id   = aws_api_gateway_rest_api.isbn_lookup_api.id
  resource_id   = aws_api_gateway_method.isbn_lookup_api.resource_id
  http_method   = aws_api_gateway_method.isbn_lookup_api.http_method
  type          = "AWS_PROXY"
  uri           = module.isbn-lookup-lambda.invoke_arn
  integration_http_method = "POST"
}

resource "aws_api_gateway_deployment" "isbn_lookup_api" {
  depends_on = [
    "aws_api_gateway_integration.isbn_lookup_api"
  ]

  rest_api_id = aws_api_gateway_rest_api.isbn_lookup_api.id
  stage_name  = "prod"
}