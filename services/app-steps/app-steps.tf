provider "aws" {
  profile = "portiz"
  region  = "us-east-1"
}

data "aws_iam_role" "step_function_lambda_execution" {
  name = "StepFunctionsLambdaExecution"
}

data "aws_lambda_function" "isbn_lookup" {
  function_name = "isbn-lookup-lambda"
}

data "aws_lambda_function" "isbn_map" {
  function_name = "isbn-map-lambda"
}

resource "aws_sfn_state_machine" "sfn_state_machine" {
  name  = "isbn-lookup-state-machine"
  role_arn  = data.aws_iam_role.step_function_lambda_execution.arn

  definition = <<EOF
    {
      "Comment": "Application state steps for ISBN Lookup",
      "StartAt": "Get ISBN Results",
      "States": {
        "Get ISBN Results": {
          "Type": "Task",
          "Resource": "${data.aws_lambda_function.isbn_lookup.arn}",
          "Next": "Map Results"
        },
        "Map Results": {
          "Type": "Task",
          "Resource": "${data.aws_lambda_function.isbn_map.arn}",
          "End": true
        }
      }
    }
  EOF
}

terraform {
  backend "s3" {
    profile = "portiz"
    region  = "us-east-1"
    bucket  = "family-apps-state-bucket"
    key     = "app-steps"
  }
}
