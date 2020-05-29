resource aws_s3_bucket guardduty {
  bucket = "${var.org_name}-audit-guardduty"
  acl    = "private"

  policy = data.aws_iam_policy_document.guardduty.json

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id      = "ARCHIVING"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.s3_days_until_glacier
      storage_class = "GLACIER"
    }
  }
}
