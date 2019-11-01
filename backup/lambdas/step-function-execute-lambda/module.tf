terraform {
  backend "s3" {
    profile = "portiz"
    region  = "us-east-1"
    bucket  = "family-apps-state-bucket"
    key     = "step-function-execute-lambda"
  }
  required_providers {
    aws = "2.33.0"
  }
  required_version = "0.12.12"
}

provider "aws" {
  profile = "portiz"
  region  = "us-east-1"
}

data "archive_file" "lambda" {
  type = "zip"
  output_path = "${path.module}/archive.zip"

  source {
    content = file("${path.module}/lambda/index.js")
    filename = "index.js"
  }
}

data "aws_iam_role" "lambda_role" {
  name = "LambdaStepFunctionExecution"
}

module "step_function_execution_lambda" {
  source        = "../../modules/lambda"
  function_name = "StepFunctionExecutionLambda"
  filename      = data.archive_file.lambda.output_path
  role          = data.aws_iam_role.lambda_role.arn
  handler       = "index.service"
}