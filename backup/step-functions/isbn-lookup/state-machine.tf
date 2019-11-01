provider "aws" {
  profile = "portiz"
  region  = "us-east-1"
}

resource "aws_sfn_state_machine" "sfn_state_machine" {
  name  = "isbn-lookup-state-machine"
  role_arn  = data.aws_iam_role.step_function_lambda_execution.arn

  definition = <<EOF
    {
      "Comment": "Application state steps for ISBN Lookup",
      "StartAt": "Compress Input",
      "States": {
        "Compress Input": {
          "Type": "Task",
          "Resource": "${data.aws_lambda_function.compress.arn}",
          "Catch": [{
            "ErrorEquals": ["States.TaskFailed"],
            "Next": "Task Failed"
          }, {
            "ErrorEquals": ["States.ALL"],
            "Next": "Task Failed"
          }],
          "Next": "Get ISBN Results"
        },
        "Get ISBN Results": {
          "Type": "Task",
          "Resource": "${data.aws_lambda_function.isbn_lookup.arn}",
          "Catch": [{
            "ErrorEquals": ["States.TaskFailed"],
            "Next": "Task Failed"
          }, {
            "ErrorEquals": ["States.ALL"],
            "Next": "Task Failed"
          }],
          "Next": "Map Results"
        },
        "Map Results": {
          "Type": "Task",
          "Resource": "${data.aws_lambda_function.isbn_map.arn}",
          "Catch": [{
            "ErrorEquals": ["States.TaskFailed"],
            "Next": "Task Failed"
          }, {
            "ErrorEquals": ["States.ALL"],
            "Next": "Task Failed"
          }],
          "Next": "Decompress Output"
        },
        "Decompress Output": {
          "Type": "Task",
          "Resource": "${data.aws_lambda_function.decompress.arn}",
          "Catch": [{
            "ErrorEquals": ["States.TaskFailed"],
            "Next": "Task Failed"
          }, {
            "ErrorEquals": ["States.ALL"],
            "Next": "Task Failed"
          }],
          "End": true
        },
        "Task Failed": {
          "Type": "Pass",
          "Result": "Fallback from a task failure",
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
    key     = "step-function-isbn-lookup"
  }
}