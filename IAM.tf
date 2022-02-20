# ----------------------------------
# IAM Role for Lambda Function 
# ----------------------------------
# Assume Role - For Lambda
data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    actions = [
    "sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
      "lambda.amazonaws.com"]
    }
  }
}

# Inline policy for ec2 stop start for lambda
data "aws_iam_policy_document" "ec2_stop_start_inline_policy" {
  statement {
    actions = [
        "ec2:StartInstances",
        "ec2:StopInstances",
    ]
    resources = [
        "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:instance/*",
    ]
  }
}

data "aws_iam_policy_document" "ec2_describe_inline_policy" {
  statement {
    actions = [
     "ec2:DescribeInstances"
    ]
    resources = [
        "*"
      ]
  }
}

# Role for Lambda and both assume and inline integrated 
resource "aws_iam_role" "lambda_iam_role_terraform" {
  name               = "Lambda-IAM-Role-For-EC2-Stop-Start"
  path               = "/lambda/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  description = "IAM role for lambda to stop start that instance which we created"

  inline_policy {
    name   = "EC2-Stop-Start-Inline-Policy"
    policy = data.aws_iam_policy_document.ec2_stop_start_inline_policy.json
  }
    inline_policy {
    name   = "EC2-Describe-Inline-Policy"
    policy = data.aws_iam_policy_document.ec2_describe_inline_policy.json
  }
}
