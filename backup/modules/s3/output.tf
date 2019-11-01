output "bucket-arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The assigned ARN for the created bucket."
}

output "bucket-name" {
  value       = aws_s3_bucket.bucket.id
  description = "The assigned name for the created bucket."
}
