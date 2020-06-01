output "cloudtrail_s3_bucket_id" {
  value = aws_s3_bucket.cloudtrail.id
    description = "ID of S3 bucket for cloudtrail"
}

output "guardduty_s3_bucket_id" {
  value = aws_s3_bucket.guardduty.id
  description = "ID of S3 bucket for GaurdDuty"
}
