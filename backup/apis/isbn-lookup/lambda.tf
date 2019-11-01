data "archive_file" "lambda" {
  type = "zip"
  output_path = "${path.module}/archive.zip"

  source {
    content = file("${path.module}/lambda/index.js")
    filename = "index.js"
  }
}

data "aws_iam_role" "lambda_role" {
  name = "BasicLambdaExecution"
}

module "isbn-lookup-lambda" {
  source        = "../../modules/lambda"
  function_name = "IsbnLookupApiLambda"
  filename      = data.archive_file.lambda.output_path
  role          = data.aws_iam_role.lambda_role.arn
  handler       = "index.service"
}

resource "aws_lambda_permission" "isbn_lookup_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.isbn-lookup-lambda.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_deployment.isbn_lookup_api.execution_arn}/*/*"
}