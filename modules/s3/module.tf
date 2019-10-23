resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket-name
  acl           = var.bucket-acl
  force_destroy = true

  versioning {
    enabled = true
  }
}
