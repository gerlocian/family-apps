provider "aws" {
  profile = "portiz"
  region  = "us-east-1"
}

variable "filename" {
  description = "The name of the lambda file to deploy"
  default     = "isbn-map"
}

data "archive_file" "lambda" {
  type = "zip"
  source_file = "${path.module}/${var.filename}.js"
  output_path = "${path.module}/${var.filename}.zip"
}

data "aws_iam_role" "lambda_role" {
  name = "BasicLambdaExecution"
}

module "isbn-lookup-lambda" {
  source            = "../../modules/lambda/"
  function_name     = "isbn-map-lambda"
  filename          = data.archive_file.lambda.output_path
  role              = data.aws_iam_role.lambda_role.arn
  handler           = "isbn-map.service"
}

terraform {
  backend "s3" {
    profile = "portiz"
    region  = "us-east-1"
    bucket  = "family-apps-state-bucket"
    key     = "isbn-map"
  }
}
