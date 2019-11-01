variable "function_name" {
  description = "The name to give the lambda on deployment."
}

variable "filename" {
  description = "The zip file to upload for the lambda."
}

variable "role" {
  description = "The role the lambda will use when it executes."
}

variable "handler" {
  description = "The handler function to execute when the lambda is invoked."
}

variable "runtime" {
  description = "The lambda runtime environment. Defaulted to nodejs 10.x."
  default     = "nodejs10.x"
}

variable "env_variables" {
  description = "A list of environment variables to use for this lambda. Defaults to an empty map."
  default     = null
  type        = map(string)
}
