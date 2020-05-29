data aws_iam_policy_document "cloudtrail" {
  statement {
    sid    = "CloudtrailAclCheck"
    effect = "Allow"
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = [
      "arn:aws:s3:::${var.org_name}-audit-cloudtrail"
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid    = "CloudTrailWrite"
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = formatlist(
      "arn:aws:s3:::${var.org_name}-audit-cloudtrail/AWSLogs/%s/*",
      [var.master_account_id, var.organization_id]
    )
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

data aws_iam_policy_document "guardduty" {
  statement {
    sid    = "OrgAccounts"
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = ["arn:Aws:s3:::${var.org_name}-audit-guardduty/*"]
    principals {
      type = "AWS"
      identifiers = formatlist(
        "arn:aws:iam::%s:root", var.account_ids
      )
    }
  }
}
