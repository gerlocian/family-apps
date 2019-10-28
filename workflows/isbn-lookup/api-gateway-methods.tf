resource "aws_api_gateway_method" "http_method" {
  rest_api_id         = aws_api_gateway_rest_api.rest_api.id
  resource_id         = aws_api_gateway_resource.resource.id
  http_method         = "GET"
  authorization       = "NONE"
  request_parameters  = {
    "method.request.querystring.q" = true
  }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.http_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  passthrough_behavior    = "NEVER"
  uri                     = "arn:aws:apigateway:us-east-1:states:action/StartExecution"
  credentials             = data.aws_iam_role.api_gateway_role.arn
  request_templates       = {
    "application/json" = <<EOF
      {
        "input": "{ \"isbn\": \"$input.params().querystring.q\" }",
        "stateMachineArn": "${aws_sfn_state_machine.sfn_state_machine.id}"
      }
    EOF
  }
  request_parameters      = {
    "integration.request.querystring.q" = "method.request.querystring.q"
  }
}