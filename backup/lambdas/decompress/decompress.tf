provider "aws" {
  profile = "portiz"
  region  = "us-east-1"
}

variable "filename" {
  description = "The name of the lambda file to deploy"
  default     = "decompress"
}

data "archive_file" "lambda" {
  type = "zip"
  output_path = "${path.module}/${var.filename}.zip"

  source {
    content = file("${path.module}/${var.filename}.js")
    filename = "${var.filename}.js"
  }

  source {
    content = file("${path.module}/../../utils/compression/compression.js")
    filename = "compression.js"
  }
}

data "aws_iam_role" "lambda_role" {
  name = "BasicLambdaExecution"
}

module "decompress-lambda" {
  source        = "../../modules/lambda"
  function_name = yamldecode(file("${path.module}/${var.filename}.yml")).functionName
  filename      = data.archive_file.lambda.output_path
  role          = data.aws_iam_role.lambda_role.arn
  handler       = "decompress.service"
  env_variables = {
    deployed = true
  }
}

terraform {
  backend "s3" {
    profile = "portiz"
    region  = "us-east-1"
    bucket  = "family-apps-state-bucket"
    key     = "decompress"
  }
}
