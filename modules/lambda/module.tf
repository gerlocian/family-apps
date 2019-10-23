terraform {
  required_providers {
    aws = "2.33.0"
  }
  required_version = "0.12.12"
}

locals {
  env_var_map = var.env_variables[*]
}

resource "aws_lambda_function" "lambda" {
  function_name     = var.function_name
  filename          = var.filename
  role              = var.role
  handler           = var.handler
  runtime           = var.runtime
  source_code_hash  = base64sha256(filebase64("${var.filename}"))

  dynamic "environment" {
    for_each = local.env_var_map
    content {
      variables = var.env_variables
    }
  }
}
