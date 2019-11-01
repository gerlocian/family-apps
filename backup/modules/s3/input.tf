variable "bucket-name" {
  description = "The name of the bucket to create."
}

variable "bucket-acl" {
  description = "The ACL of the bucket. Values are defined here: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl. Defaults to 'private'"
  default     = "private"
}
