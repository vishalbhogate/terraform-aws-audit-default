resource aws_iam_role "audit" {
  count              = var.create_audit_role ? 1 : 0
  name               = "${var.org_name}-audit"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Action": "sts:AssumeRole",
            "Principal": {
                "AWS": "arn:aws:iam:${var.idp_account_id}:root"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource aws_iam_policy "audit" {
  count  = var.create_audit_role ? 1 : 0
  name   = "${var.org_name}-audit"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "kms:List*",
                "kms:Get*",
                "kms:Describe*",
                "kms:Decrypt"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
resource aws_iam_role_policy_attachment "audit" {
  count      = var.create_audit_role ? 1 : 0
  role       = aws_iam_role.audit[0].id
  policy_arn = aws_iam_policy.audit[0].arn
}
